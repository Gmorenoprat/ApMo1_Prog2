using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InstanciarDespues : MonoBehaviour
{

     public GameObject[] listGO;
    void Start()
    {
        foreach (GameObject g in listGO)
        {
            g.SetActive(false);
        }
        StartCoroutine(iniciarDispar());
    }

    public IEnumerator iniciarDispar()
    {
        foreach (GameObject g in listGO)
        {
            g.SetActive(true);
            yield return new WaitForSeconds(2f);
        }
        yield return null;
    }
}
