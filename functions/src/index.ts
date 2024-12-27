import {https} from "firebase-functions";

// Firebase Admin setup
import admin from "firebase-admin";

// Initialize Firebase Admin
admin.initializeApp();

// Reference Firestore
const db = admin.firestore();

// Fetch data from Firestore
export const fetchTrainingsData = https.onRequest(async (req, res) => {
  try {
    // Replace "your-collection-name" with your Firestore collection name
    const snapshot = await db.collection("trainings").get();
    // Map data to an array and convert "fromTime" and "toTime" to ISO strings
    const data = snapshot.docs.map((doc) => {
      const docData = doc.data();
      return {
        id: doc.id,
        ...docData,
        // Convert fromTime and toTime to ISO strings
        fromTime: docData.fromTime ?
          docData.fromTime.toDate().toISOString() : null,
        toTime: docData.toTime ?
          docData.toTime.toDate().toISOString() : null,
      };
    });
    // Send data as response
    res.status(200).json({data});
  } catch (error) {
    console.error("Error fetching data:", error);
    res.status(500).json({error: "Internal Server Error"});
  }
});
