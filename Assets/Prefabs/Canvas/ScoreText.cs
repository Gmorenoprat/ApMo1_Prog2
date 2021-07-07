using UnityEngine.UI;
using UnityEngine;

public class ScoreText : MonoBehaviour
{
    public Text appleText;
    public Text lifeText;

    public Player player;

    private void Start()
    {
        player = GameObject.FindGameObjectWithTag("Player").GetComponent<Player>();
    }
    void Update()
    {
        lifeText.text = player.life.ToString();
        appleText.text = player.apples.ToString();
    }
}
