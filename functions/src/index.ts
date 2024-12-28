import {https} from "firebase-functions";

// Firebase Admin setup
import admin from "firebase-admin";

// Initialize Firebase Admin
admin.initializeApp();

// Reference Firestore
const db = admin.firestore();

// Define the document structure
type TrainingDocument = {
  id: string;
  fromTime?: FirebaseFirestore.Timestamp;
  toTime?: FirebaseFirestore.Timestamp;
  title?: string;
  location?: string;
  trainer?: {name?: string};
};

// Fetch trainings data from Firestore
export const fetchTrainingsData = https.onRequest(async (req, res) => {
  try {
    // Parse the incoming request body
    const decodedArgs = typeof req.body === "string" ?
      JSON.parse(req.body) : req.body;
    // Access the data
    const location = decodedArgs.location || [];
    const title = decodedArgs.title || [];
    const trainerName = decodedArgs.trainerName || [];

    // Fetch all documents
    const snapshot = await db.collection("trainings").get();
    // Map data to an array and convert "fromTime" and "toTime" to ISO strings
    const data = snapshot.docs.map((doc) => {
      const docData = doc.data() as TrainingDocument;
      return {
        ...docData,
        fromTime: docData.fromTime ?
          docData.fromTime.toDate().toISOString() : null,
        toTime: docData.toTime ?
          docData.toTime.toDate().toISOString() : null,
      };
    });
    // Check if any filter criteria are provided
    const hasFilters = location.length > 0 ||
      title.length > 0 || trainerName.length > 0;

    if (!hasFilters) {
      // If no filters are present, return all documents
      res.status(200).json({data});
      return;
    }

    // Filter the data in the cloud function
    const filteredData = data.filter((doc) => {
      const locationMatch = location.length === 0 ||
        location.some((loc: string) =>
          doc.location?.toLowerCase().includes(loc.toLowerCase())
        );
      const titleMatch = title.length === 0 ||
        title.some((t: string) =>
          doc.title?.toLowerCase().includes(t.toLowerCase())
        );
      const trainerMatch = trainerName.length === 0 ||
        trainerName.some((tn: string) =>
          doc.trainer?.name?.toLowerCase().includes(tn.toLowerCase())
        );

      return locationMatch && titleMatch && trainerMatch;
    });

    // Send filtered data as response
    res.status(200).json({data: filteredData});
  } catch (error) {
    console.error("Error fetching data:", error);
    res.status(500).json({error: "Internal Server Error"});
  }
});

// Fetch 3 random trainings data from Firestore
export const fetchHighlightedTrainings = https.onRequest(async (_, res) => {
  try {
    // Get a count of documents in the 'trainings' collection
    const snapshot = await db.collection("trainings").get();

    // If there are fewer than 3 documents, return all of them
    if (snapshot.size <= 3) {
      const data = snapshot.docs.map((doc) => {
        const docData = doc.data() as TrainingDocument;
        return {
          ...docData,
          fromTime: docData.fromTime ?
            docData.fromTime.toDate().toISOString() : null,
          toTime: docData.toTime ?
            docData.toTime.toDate().toISOString() : null,
        };
      });
      res.status(200).json({data});
      return;
    }

    // Create an array of all document IDs
    const docIds = snapshot.docs.map((doc) => doc.id);

    // Shuffle the document IDs array to get a random order
    const shuffledDocIds = docIds.sort(() => Math.random() - 0.5);

    // Take the first 3 document IDs
    const randomDocIds = shuffledDocIds.slice(0, 3);

    // Fetch the 3 random documents by their IDs
    const randomDocs = await Promise.all(
      randomDocIds.map((id) =>
        db.collection("trainings").doc(id).get()
      )
    );

    // Map the random docs to the desired response format
    const data = randomDocs.map((doc) => {
      const docData = doc.data() as TrainingDocument;
      return {
        ...docData,
        fromTime: docData.fromTime ?
          docData.fromTime.toDate().toISOString() : null,
        toTime: docData.toTime ?
          docData.toTime.toDate().toISOString() : null,
      };
    });

    // Send the random trainings as response
    res.status(200).json({data});
  } catch (error) {
    console.error("Error fetching highlighted trainings:", error);
    res.status(500).json({error: "Internal Server Error"});
  }
});
