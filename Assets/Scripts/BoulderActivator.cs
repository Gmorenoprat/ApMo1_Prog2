using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// @Author: 
/// </summary>
public class BoulderActivator : MonoBehaviour
{
    public Boulder boulder;

    public void Start()
    {
        EventManager.SubscribeToEvent(EventsType.ACTIVATOR_TRIGGER, ActivateBoulder);
    }
    public void ActivateBoulder(params object[] parameterContainer)
    {
        Boulder boulder = (Boulder)parameterContainer[0];
        boulder.Activate();
    }
    public void OnTriggerEnter(Collider other)
    {
        EventManager.TriggerEvent(EventsType.ACTIVATOR_TRIGGER, boulder);
    }
    //public void OnTriggerExit(Collider other)
    //{
    //    if (!other.GetComponent<Boulder>()) { return; }
    //    Boulder player = other.GetComponent<Boulder>();
    //    EventManager.TriggerEvent(EventsType.ACTIVATOR_TRIGGER, player, player.baseSpeed);
    //}
}
