const {Storage} = require('@google-cloud/storage');

const storage = new Storage({
    keyFilename: "tremordetection-firebase-adminsdk-o626g-c4d9174ebc.json",
});

const bucketName = 'tremordetection.appspot.com';

const data_ios_simulation_folder = './iOS/Simulation/data4/';

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

const uploadIOSDataFiles = async function() {
	const readdir = util.promisify(fs.readdir);

	let names;
	try {
	    files = await readdir(data_ios_simulation_folder);
	    for (const file of files) {
			await uploadFile(file, 'Simulation/data4');
		}
	} catch (err) {
	    console.log(err);
	}
}


uploadIOSDataFiles();