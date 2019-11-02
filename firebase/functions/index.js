const functions = require('firebase-functions');
const request = require('request-promise-native');
const SERVER = 'http://34.243.78.23/';

exports.blockchain = functions.https.onRequest(async (req, res) => {
    try {
        let content = await request.get(SERVER);
        res.send(content);
    } catch (error) {
        res.send('Server blockchain tidak aktif');
    }
});

exports.tambahServis = functions.firestore.document('mobil/{id_mobil}/servis/{id}').onCreate(async (snap, context) => {
    let data = snap.data();
    data.id_mobil = context.params.id_mobil;

    try {
        let result = await request.post(SERVER + 'tambahServis', {
            form: {
                id: snap.id,
                data: JSON.stringify(data),
            },
        });
        await snap.ref.update({ transaction: result });
    } catch (error) {

    }
});

exports.tambahParts = functions.firestore.document('mobil/{id_mobil}/spareparts/{id}').onCreate(async (snap, context) => {
    let data = snap.data();
    data.id_mobil = context.params.id_mobil;

    try {
        let result = await request.post(SERVER + 'tambahParts', {
            form: {
                id: snap.id,
                data: JSON.stringify(data),
            },
        });
        await snap.ref.update({ transaction: result });
    } catch (error) {

    }
});
