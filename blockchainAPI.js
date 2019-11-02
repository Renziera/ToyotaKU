const Web3 = require('web3');
const fs = require('fs');
const express = require('express');

const web3 = new Web3('http://localhost:8545');
const abi = JSON.parse(fs.readFileSync('./contract.abi').toString());
const contractAddress = '0x162831A496D08421415dD8188C9910BdDEcA6678';
const contract = new web3.eth.Contract(abi, contractAddress);
const app = express();
const port = 3000;

const options = {
    from: '0x4dEDb9F6b149963b416AdCaD9b1d920418d4CdB0',
    gas: 6721975,
    gasPrice: 20000000000,
};

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get('/', (req, res) => {
    let header = '<!DOCTYPE html><html><head><title>Blockchain Log</title><style>body{color: white;background-color: black;font-family: \'Courier New\', Courier, monospace;}</style></head><body>';
    let ganacheLog = fs.readFileSync('./log').toString().split('\n').join('\n<br>\n');
    let scrollDown = '<script>window.scrollTo(0,document.body.scrollHeight);</script></body></html>';
    res.send(header + ganacheLog + scrollDown);
});

app.post('/tambahServis', (req, res) => {
    contract.methods.tambahServis(
        req.body.id,
        req.body.data,
        Math.trunc((new Date()).getTime() / 1000),
    ).send(options, (err, result) => res.send(result));
});

app.post('/tambahParts', (req, res) => {
    contract.methods.tambahParts(
        req.body.id,
        req.body.data,
    ).send(options, (err, result) => res.send(result));
});

app.listen(port, () => console.log(`ToyotaKU Blockchain API running on port ${port}`))

