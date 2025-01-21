// Import required libraries
import { initializeApp } from 'firebase/app';
import { getFirestore, doc, getDoc, setDoc } from 'firebase/firestore';
import { Client, Storage } from 'appwrite';
import fetch from 'node-fetch'; // For making API calls in Node.js environment

// Firebase configuration
const firebaseConfig = {
    // Your Firebase configuration details
    apiKey: "YOUR_API_KEY",
    authDomain: "YOUR_AUTH_DOMAIN",
    projectId: "YOUR_PROJECT_ID"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

/**
 * Fetch user details from Firestore
 * @param {string} customerId - Customer identifier
 * @param {string} file - Document name to retrieve
 * @returns {Promise<Object>} User document data
 */
async function userDetail(customerId, file) {
    try {
        const docRef = doc(db, customerId, file);
        const docSnap = await getDoc(docRef);

        if (docSnap.exists()) {
            console.log("Document data:", docSnap.data());
            return docSnap.data(); // Corrected from .json() to .data()
        } else {
            console.log("No such document!");
            return {};
        }
    } catch (error) {
        console.error("Error fetching user details:", error);
        return {};
    }
}

/**
 * Call Aadhaar API for verification
 * @returns {Promise<Object>} API response
 */
async function callAadhaarApi() {
    const apiUrl = "https://test-aadhaar-api.example.com/verify";
    
    const requestBody = {
        aadhaarNumber: "123456789012",
        otp: "123456"
    };

    try {
        const response = await fetch(apiUrl, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Accept": "application/json"
            },
            body: JSON.stringify(requestBody)
        });

        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }

        const jsonResponse = await response.json();
        console.log("Response JSON:", jsonResponse);
        return jsonResponse;

    } catch (error) {
        console.error("Error calling Aadhaar API:", error.message);
        return { error: error.message };
    }
}

/**
 * Call Credit Bureau API for credit check
 * @returns {Promise<Object>} API response
 */
async function callCreditBureauApi() {
    const apiUrl = "https://api.creditbureau.com/v1/credit-check";
    const apiKey = "your-api-key";

    const requestBody = {
        firstName: "John",
        lastName: "Doe",
        dateOfBirth: "1990-01-01",
        panNumber: "ABCDE1234F",
        address: "1234 Elm Street, Anytown, USA"
    };

    try {
        const response = await fetch(apiUrl, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Authorization": `Bearer ${apiKey}`
            },
            body: JSON.stringify(requestBody)
        });

        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }

        const jsonResponse = await response.json();
        console.log("Credit Bureau Response:", jsonResponse);
        return jsonResponse;

    } catch (error) {
        console.error("Error calling Credit Bureau API:", error.message);
        return { error: error.message };
    }
}

/**
 * Convert video to text (placeholder function)
 * @returns {string} Extracted text
 */
function videoToText() {
    return ""; // Implement actual video-to-text logic
}

/**
 * Upload JSON data to Appwrite storage
 * @param {Object} jsonData - Data to upload
 * @param {string} bucketId - Storage bucket ID
 * @param {string} fileName - Name of the file to upload
 * @returns {Promise<Object|null>} Upload response
 */
async function storages(jsonData, bucketId, fileName) {
    const client = new Client()
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('678dd115000bfb7da92d');

    const storage = new Storage(client);

    try {
        const jsonBlob = new Blob([JSON.stringify(jsonData)], { type: "application/json" });
        const file = new File([jsonBlob], fileName, { type: "application/json" });
        
        const response = await storage.createFile(bucketId, "unique()", file);
        
        console.log("File uploaded successfully:", response);
        return response;
    } catch (error) {
        console.error("Error uploading file:", error);
        return null;
    }
}

/**
 * Check free time for a specific service (placeholder function)
 * @param {string} service - Service to check
 * @returns {string|null} Available filename or null
 */
function checkFreeTime(service) {
    // Implement actual free time checking logic
    return null;
}

/**
 * Upload multiple documents to storage
 * @param {Array} array - Array of documents to upload
 * @param {string} department - Department folder
 */
async function uploadDoc(array, department) {
    for (let i = 0; i < array.length; i++) {
        await storages(array[i], department, `document_${i}`);
    }
}

/**
 * Generate ticket schedule
 * @param {string} status - Ticket status
 */
async function ticketSchedule(status) {
    const data = {
        ticketId: {
            name: "ram sharma",
            query: "housing loan",
            officer: "anaya mehta",
            status: status,
            date: new Date().toISOString() // Use current timestamp
        }
    };
    await writeDocument("dumay", "ticket", data);
}

/**
 * Write document to Firestore
 * @param {string} customerId - Customer identifier
 * @param {string} documentId - Document identifier
 * @param {Object} data - Data to write
 */
async function writeDocument(customerId, documentId, data) {
    try {
        const docRef = doc(db, customerId, documentId);
        await setDoc(docRef, data);
        console.log(`Document with ID '${documentId}' written successfully.`);
    } catch (error) {
        console.error("Error writing document:", error);
    }
}

/**
 * Generate ticket based on query type
 */
async function ticketGeneration() {
    const query = videoToText();
    const departments = ["loan", "deposit", "account", "fraud", "investment"];

    for (const department of departments) {
        if (query.includes(department)) {
            const filename = checkFreeTime(department);
            
            if (!filename) {
                await ticketSchedule("Waiting");
                return; // Exit function instead of using break
            }

            // Fetch user details dynamically
            const detailsToFetch = {
                "loan": ["profile", "account", "loan", "transaction", "service", "assest"],
                "deposit": ["profile", "account", "loan", "transaction", "service", "assest"],
                "account": ["profile", "account", "transaction", "service"],
                "fraud": ["profile", "account", "transaction", "service"],
                "investment": ["profile", "account", "assest"]
            };

            const userDetails = await Promise.all(
                detailsToFetch[department].map(detail => 
                    userDetail("dumay", detail)
                )
            );

            await uploadDoc(userDetails, department);
            break; // Exit loop after processing
        }
    }

    await ticketSchedule("call schedule");
}

// Export functions if needed
export {
    userDetail,
    callAadhaarApi,
    callCreditBureauApi,
    ticketGeneration
};
