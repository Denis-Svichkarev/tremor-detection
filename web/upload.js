const {Storage} = require('@google-cloud/storage');

const storage = new Storage({
    keyFilename: "tremordetection-firebase-adminsdk-o626g-c4d9174ebc.json",
});

const bucketName = 'tremordetection.appspot.com';

const data1_ios_simulation_folder = './iOS/Simulation/data1/';
const data6_ios_simulation_folder = './iOS/Simulation/data6/';

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

const uploadIOSData1Files = async function() {
	const readdir = util.promisify(fs.readdir);

	let names;
	try {
	    files = await readdir(data1_ios_simulation_folder);
	    for (const file of files) {
			await uploadFile(file, 'Simulation/data1');
		}
	} catch (err) {
	    console.log(err);
	}
}

const uploadIOSData6Files = async function() {
	const readdir = util.promisify(fs.readdir);

	let names;
	try {
	    files = await readdir(data6_ios_simulation_folder);
	    for (const file of files) {
			await uploadFile(file, 'Simulation/data6');
		}
	} catch (err) {
	    console.log(err);
	}
}

uploadIOSData1Files();
uploadIOSData6Files();