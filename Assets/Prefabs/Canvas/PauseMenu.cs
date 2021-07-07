using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PauseMenu : MonoBehaviour
{
    public static bool GameIsPaused = false;

    public GameObject pauseGameUI;
    public GameObject interfaceUI;
    public GameObject gameOverUI;

    public Player player;

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Escape))
        {
            if (GameIsPaused)
            {
                Resume();
            }
            else
            {
                Pause();
            }
        }

        if(player != null && player.life <= 0)
        {
            Invoke("GameOver", 2f);
        }

    }

    public void Resume()
    {
        pauseGameUI.SetActive(false);
        gameOverUI.SetActive(false);
        interfaceUI.SetActive(true);
        Time.timeScale = 1f;
        GameIsPaused = false;
    }

    void Pause()
    {
        pauseGameUI.SetActive(true);
        interfaceUI.SetActive(false);
        Time.timeScale = 0f;
        GameIsPaused = true;
    }

    void GameOver()
    {
        gameOverUI.SetActive(true);
        interfaceUI.SetActive(false);
        Time.timeScale = 0f;
        GameIsPaused = false;
    }
}
