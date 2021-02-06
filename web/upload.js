const {Storage} = require('@google-cloud/storage');

const storage = new Storage({
    keyFilename: "tremordetection-firebase-adminsdk-o626g-c4d9174ebc.json",
});

const bucketName = 'tremordetection.appspot.com';

const iosSimulationFolder = './iOS/Simulation/';
const iosMovementFolder = './iOS/Movement/';

const fs = require('fs');
const util = require('util');

function uploadFile(filename, folder) {
    storage.bucket(bucketName).upload('iOS/' + folder + '/' + filename, {
        gzip: true,
        metadata: {
            cacheControl: 'public, max-age=31536000',
        },
        destination: 'iOS/' + folder + '/' + filename,
	});
};

const uploadSimulationFiles = async function() {
	const readdir = util.promisify(fs.readdir);

	let names;
	try {
	    files = await readdir(iosSimulationFolder);
	    for (const file of files) {
			await uploadFile(file, 'Simulation');
		}
	} catch (err) {
	    console.log(err);
	}
}

const uploadMovementFiles = async function() {
	const readdir = util.promisify(fs.readdir);

	let names;
	try {
	    files = await readdir(iosMovementFolder);
	    for (const file of files) {
			await uploadFile(file, 'Movement');
		}
	} catch (err) {
	    console.log(err);
	}
}

uploadSimulationFiles();
uploadMovementFiles();