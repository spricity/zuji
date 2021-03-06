<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="zh-CN">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>
            &rsaquo; 登录
        </title>
        <link rel='stylesheet' id='wp-admin-css' href='<?=B?>/www/wp-admin.css'
        type='text/css' media='all' />
        <link rel='stylesheet' id='colors-fresh-css' href='<?=B?>/www/colors-fresh.css'
        type='text/css' media='all' />
        <link rel="stylesheet" href="<?=B?>/www/index.css">
        <meta name='robots' content='noindex,nofollow' />
        <script type="text/javascript" src="<?=B?>/www/jquery.js"></script>
    </head>

    <body class="login">
        <div id="login">
            <h1>
                <a href="<?=B?>" title="足迹">
                    聚划算-足迹-登录
                </a>
            </h1>
            <form name="loginform" id="loginform" action="<?=B?>/user/login"
            method="post">
                <p>
                    <label for="user_login">
                        用户名
                        <br />
                        <input type="text" name="uname" id="uname" class="input" value="" size="20"
                        tabindex="10" />
                    </label>
                </p>
                <p>
                    <label for="user_pass">
                        密码
                        <br />
                        <input type="password" name="pwd" id="user_pass" class="input" value=""
                        size="20" tabindex="20" />
                    </label>
                </p>
                <p class="forgetmenot">
                    <label for="rememberme">
                        <input name="rememberme" type="checkbox" id="rememberme" value="forever"
                        tabindex="90" />
                        记住我的登录信息
                    </label>
                </p>
                <p class="submit">
                    <input type="submit" name="wp-submit" id="wp-submit" class="button-primary"
                    value="登录" tabindex="100" />
                    <input type="hidden" name="go" value="<?=$go?>"
                    />
                    <input type="hidden" name="action" value="login"
                    />
                </p>
            </form>
            <p id="nav">
                <a href="<?=B?>/user/register">
                    注册
                </a>
                |
                <a href="mailto:chuncheng.licc@taobao.com" title="找回密码">
                    忘记密码？
                </a>
            </p>
            <script type="text/javascript">
                function wp_attempt_focus() {
                    setTimeout(function() {
                        try {
                            d = document.getElementById('uname');
                            d.focus();
                            d.select();
                        } catch(e) {}
                    },
                    200);
                }

                wp_attempt_focus();
            </script>
            <p id="backtoblog">
                <a href="<?=B?>" title="不知道自己在哪？">
                    &larr; 回到 足迹
                </a>
            </p>
        </div>
        <div class="clear">
        </div>
<?=_v('footer.tpl')?>