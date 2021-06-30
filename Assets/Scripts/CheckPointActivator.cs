using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CheckPointActivator : MonoBehaviour
{
    private bool checkYaActivado = false;
    public AudioSource playersound;

    public void Start()
    {
        EventManager.SubscribeToEvent(EventsType.CHECKPOINT_TRIGGER, triggerCheckPoint);
    }
    public void triggerCheckPoint(params object[] parameterContainer)
    {
        Player player = (Player)parameterContainer[0];
        player.gameObject.GetComponent<Player>().SaveCheckPoint();
        playersound.Play(0);
        checkYaActivado = true;
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == "Player")
        {
            EventManager.TriggerEvent(EventsType.CHECKPOINT_TRIGGER, other.gameObject.GetComponent<Player>());
        }
    }
}

 

