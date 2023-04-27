/***************************************************************************************************
 * Name: Bryan Aguiar
 * Due Date: 12/15/20
 * Assignment: Assignment 7 - Simple Android App
 * Description:
 *  The program
 **************************************************************************************************/
package com.example.assign7;

// Import statements
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

// Main Activity Class
public class MainActivity extends AppCompatActivity
{
    // Instance variables
    TextView tvClasses;
    TextView tvClasses2;
    Button btnSubmit;
    EditText etCourseNumber;

    // current folder where java is located for our second activity
    public static final String EXTRA_MESSAGE = "com.example.assign7.MESSAGE";

    // function that initializes the screen. the first to be initialized by the app
    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        tvClasses = findViewById(R.id.tvClasses);
        tvClasses2 = findViewById(R.id.tvClasses2);
        btnSubmit = findViewById(R.id.btnSubmit);
        etCourseNumber = (EditText) findViewById(R.id.etCourseNumber);

        // Applies the string to course view which contains the classes before the elective choice
        String courseView = getString(R.string.string_course1) + getString(R.string.newline)
                + getString(R.string.string_course2) + getString(R.string.newline) +
                getString(R.string.string_course3) + getString(R.string.newline) +
                getString(R.string.string_course4) + getString(R.string.newline) +
                getString(R.string.string_course5) + getString(R.string.newline) +
                getString(R.string.string_course6) + getString(R.string.newline) +
                getString(R.string.string_course7) + getString(R.string.newline) +
                getString(R.string.string_course8) + getString(R.string.newline) +
                getString(R.string.string_course9) + getString(R.string.newline) +
                getString(R.string.string_course10) + getString(R.string.newline);

        // applies the rest of the classes
        String courseView2 = getString(R.string.string_course11) + getString(R.string.newline)
                + getString(R.string.string_course12) + getString(R.string.newline)
                + getString(R.string.string_course13) + getString(R.string.newline) +
                getString(R.string.string_course14) + getString(R.string.newline);

        // display the two sets to the textview
        tvClasses.setText(courseView);
        tvClasses2.setText(courseView2);
    }

    // function that sends the message by the user to the second activity
    // @param view - a view object that sends info to the second activity
    public void sendMessage(View view)
    {

        String input = etCourseNumber.getText().toString();
        if (validateMessage(input))
        {
            Intent intent = new Intent(this, DisplayMessageActivity.class);
            intent.putExtra(EXTRA_MESSAGE, input);
            startActivity(intent);
        }

        else
        {
            Toast.makeText(getApplicationContext(), getString(R.string.digit_error),
                    Toast.LENGTH_LONG).show();
        }
    }

    /*
    function that validates the input from the user if they happen to send invalid characters
    @param - a string message containing the input from the user
    @return - a boolean of whether or not the message is valid
     */
    public boolean validateMessage(String message)
    {
        // will only remain true if user input is valid
        boolean valid = true;
        // if any input is invalid valid becomes false.
        for (int i = 0; i < message.length(); i++)
        {
            if (!Character.isDigit(message.charAt(i)))
            {
                valid = false;
                break;
            }
        }

        // return the boolean value of valid.
        return valid;
    }

}