using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CheckPointActivator : MonoBehaviour
{
    private bool checkYaActivado = false;
    public AudioSource playersound;

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == "Player" && !checkYaActivado)
        {
            other.gameObject.GetComponent<Player>().SaveCheckPoint();
            playersound.Play(0);
            checkYaActivado = true;
        }
    }

 
}
