const {Storage} = require('@google-cloud/storage');

const storage = new Storage({
    keyFilename: "tremordetection-firebase-adminsdk-o626g-c4d9174ebc.json",
});

const bucketName = 'tremordetection.appspot.com';

const downloadFiles = async() => {
	await storage.bucket(bucketName).getFiles((err, files) => {     
		if(!err){         
			files.forEach(file => {   
				const srcFilename = file.metadata.name;

				if (srcFilename.includes('.csv') || srcFilename.includes('.m4a') || srcFilename.includes('.mp4')) {
					const options = {
				 		destination: "./" + srcFilename,
					};

					file.download(options); 
				}				
			});     
		} else {         
			console.log(err);     
		} 
	});
};

downloadFiles();
