// Based on https://github.com/ericf/express-handlebars

const port = 3000;
const express = require('express');
const hb  = require('express-handlebars');
const app = express();
var path = require('path');

const mysql = require('mysql');
const connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'password',
  database : 'MoodApp'
});

const query_get_mood_colors = 'CALL getMoods()';
const query_moods_user = 'CALL getVizDetails()'; 
const query_insert_user_mood = 'CALL insertUserMood(?,?,?,?)';
const query_getUserInfo = 'CALL getUserDetails();';
const query_calendarInfo = 'CALL getMoodsFromView()'; 
const query_most_freq = "SELECT MostFrequentMood()";

var errorFlag = false;
var firstSubmit = true;

app.engine('handlebars', hb({defaultLayout: 'main'}));
app.set('view engine', 'handlebars');
app.use(express.urlencoded());


app.use(express.static(path.join(__dirname, '/public')));

app.get('/', function (req, res) {
    connection.query(query_get_mood_colors, (error, results, fields) => {
       results = results[0];
        if (error) {
            throw error;
        }
		connection.query(query_moods_user, (error2, colorInfo, fields2) => {
            colorInfo = colorInfo[0];
            if (error2) {
				throw error2;
			}
			res.render('home', { results, colorInfo, errorFlag, firstSubmit });
		});    
    });
});

app.get('/api/user/profile', function (req, res) {
	 connection.query(query_getUserInfo, (error, profInfo, fields) => {
        profInfo = profInfo[0];
        if (error) {
            throw error;
        }
	res.render('profile', {profInfo});
	});
});

app.get('/api/user/calendar', function (req, res) {
	connection.query(query_calendarInfo, (error, calInfo, fields) => {
        calInfo = calInfo[0];
        if (error) {
            throw error;
        }
        connection.query(query_most_freq, (error, freqInfo, fields) => {
            if (error){
                
            }
            if (freqInfo[0]['MostFrequentMood()']!=null){
                var freqInfoMood = freqInfo[0]['MostFrequentMood()'].split('|')[0];
                var freqInfoColor = freqInfo[0]['MostFrequentMood()'].split('|')[1];
            }
            res.render('calendar', { calInfo, freqInfoMood, freqInfoColor });
        });
	});
});

app.post('/api/user/create', (req, res) => {
    const user = "test";
	const date = req.body.startTime;
	const moodID = req.body.moodSelect.split(':')[0];
    const duration = req.body.duration;
    //const emplid = req.body.userID;
    connection.query(query_insert_user_mood, [user, date, moodID, duration], (error, results, fields) => {
        if (error) {
            errorFlag = true;
            firstSubmit = false;
        } else {
            errorFlag = false;
            firstSubmit = false;
        }
        res.redirect('/')
    });
});


app.listen(3000);

