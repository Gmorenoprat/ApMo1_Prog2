using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CheckPointActivator : MonoBehaviour
{
    public AudioSource playersound;

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == "Player")
        {
           other.gameObject.GetComponent<PlayerController>().SaveCheckPoint();
            playersound.Play(0);
        }
    }

 
}
