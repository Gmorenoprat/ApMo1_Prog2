using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class torchAutoStart : MonoBehaviour
{
    public GameObject player;
    public GameObject[] lights;
    public float distanceToLight = 15;
    
    public void Awake()
    {
        player = GameObject.FindGameObjectWithTag("Player");
    }
    
    void Update()
    {
        if(player != null)
        {
            if (Vector3.Distance(this.gameObject.transform.position, player.transform.position) < distanceToLight)
            {
                foreach (GameObject light in lights)
                {
                    light.SetActive(true);
                }
            }
            else
            {
                foreach (GameObject light in lights)
                {
                    light.SetActive(false);
                }
            }
        }
    }
}
