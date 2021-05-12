using UnityEngine.UI;
using UnityEngine;

public class ScoreText : MonoBehaviour
{
    public Text appleText;
    public Text lifeText;

    public Player player;

    void Update()
    {
        lifeText.text = player.life.ToString();
        appleText.text = player.apples.ToString();
    }
}
