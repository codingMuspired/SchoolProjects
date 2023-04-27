package com.example.assign7;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Switch;
import android.widget.TextView;

// second activity class
public class DisplayMessageActivity extends AppCompatActivity
{

    // instance variables
    TextView tvCourseDescription;
    TextView tvCourseName;

    // function similar to main in that it is required upon creating of the second activity
    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_display_message);

        tvCourseDescription = findViewById(R.id.tvCourseDescription);
        tvCourseName = findViewById(R.id.tvCourseName);

        // Get the Intent that started this activity and extract the string
        Intent intent = getIntent();
        String message = intent.getStringExtra(MainActivity.EXTRA_MESSAGE);
        int intMessage = Integer.parseInt(message);

        // Capture the layout's TextView and set the string as its text
        String description = getCourseDescription(intMessage);
        String course = getCourseName(intMessage);
        tvCourseName.setText(course);
        tvCourseDescription.setText(description);
    }

    // function that retrieves the name string of the input
    // @param CourseNumber - an int containing the courseNumber of the class to be returned
    // @return a string that contains the name of the course or error depending on output
    String getCourseName(int CourseNumber)
    {
        String course;
        // a switch statement that will only call the expected course otherwise string displays
        // error
        switch (CourseNumber)
        {
            case 300:
                course = getString(R.string.string_course1);
                break;
            case 338:
                course = getString(R.string.string_course2);
                break;
            case 363:
                course = getString(R.string.string_course3);
                break;
            case 334:
                course = getString(R.string.string_course4);
                break;
            case 311:
                course = getString(R.string.string_course5);
                break;
            case 336:
                course = getString(R.string.string_course6);
                break;
            case 462:
                course = getString(R.string.string_course7);
                break;
            case 328:
                course = getString(R.string.string_course8);
                break;
            case 370:
                course = getString(R.string.string_course9);
                break;
            case 383:
                course = getString(R.string.string_course10);
                break;
            case 325:
                course = getString(R.string.string_course11);
                break;
            case 329:
                course = getString(R.string.string_course12);
                break;
            case 438:
                course = getString(R.string.string_course13);
                break;
            case 499:
                course = getString(R.string.string_course14);
                break;
            default:
                course = getString(R.string.course_name_error);
                break;
        }
        // return value in string course
        return course;
    }

    // function that retries description for specific courses
    // @param CourseNumber - similar to name, it's an int containing the number of the course
    // @return - description of the course if number is valid.
    String getCourseDescription(int CourseNumber)
    {

        String course;
        switch (CourseNumber)
        {
            case 300:
                course = getString(R.string.string_description1);
                break;
            case 338:
                course = getString(R.string.string_description2);
                break;
            case 363:
                course = getString(R.string.string_description3);
                break;
            case 334:
                course = getString(R.string.string_description4);
                break;
            case 311:
                course = getString(R.string.string_description5);
                break;
            case 336:
                course = getString(R.string.string_description6);
                break;
            case 462:
                course = getString(R.string.string_description7);
                break;
            case 328:
                course = getString(R.string.string_description8);
                break;
            case 370:
                course = getString(R.string.string_description9);
                break;
            case 383:
                course = getString(R.string.string_description10);
                break;
            case 325:
                course = getString(R.string.string_description11);
                break;
            case 329:
                course = getString(R.string.string_description12);
                break;
            case 438:
                course = getString(R.string.string_description13);
                break;
            case 499:
                course = getString(R.string.string_description14);
                break;
            default:
                course = getString(R.string.course_description_error);
                break;
        }
        return course;
    }
}