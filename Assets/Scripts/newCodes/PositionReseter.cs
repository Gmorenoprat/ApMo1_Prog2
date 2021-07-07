using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PositionReseter : MonoBehaviour
{
    Vector3 iniPos;
    public GameObject player;
    // Start is called before the first frame update
    public void Awake()
    {
        iniPos = this.gameObject.transform.position;
        player = GameObject.FindGameObjectWithTag("Player");
    }

    // Update is called once per frame
    void Update()
    {
        if(player != null)
        {
            if (player.GetComponent<Player>().invencibility == true)
            {
                this.gameObject.transform.position = iniPos;
                this.gameObject.GetComponent<FallingPlatform>().isFalling = false;
            }
        }
    }
}
