Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A6178F2D5
	for <lists+linux-scsi@lfdr.de>; Thu, 31 Aug 2023 20:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbjHaSm1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 31 Aug 2023 14:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjHaSmZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 31 Aug 2023 14:42:25 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1845410C8
        for <linux-scsi@vger.kernel.org>; Thu, 31 Aug 2023 11:42:17 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68bee12e842so953127b3a.3
        for <linux-scsi@vger.kernel.org>; Thu, 31 Aug 2023 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693507336; x=1694112136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tz4a2x19zbfNUm77S91HyO3WUpP/Tfo2YEu/Zh4ddEg=;
        b=WXjYVGlH0bDciHH8xzHjB9eVOAkttQguc8MMRsSScYw+J4N/8KaJHTfSp1MWmWWnUd
         GHrUyzZwJw/UvN/xePqvWpS5c5mmD29Zumq2aWGlFBkde+9RBNEt6yFBd+7Uiuz+2PAp
         tNwaf/iv1Q47LHUllFNc7NeXiKzxyrQdsaK1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693507336; x=1694112136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tz4a2x19zbfNUm77S91HyO3WUpP/Tfo2YEu/Zh4ddEg=;
        b=YC4AYcZ7MH6bQE7HqGxrg7/VYH9SAw3mP/vezcVPWZkeqxO+zEt/Cz2wxzGVTJinQ0
         BouCaZYx1luFWWktK7dZNzfjmHNb2PcCLahwmOtmXvpI75vURbEQzaJp4ID0ClVtscS2
         /Z8Zl+SpyhBTi6zw6sg8zJRzHwyINHgtplzzXvLM7oBE612Aliiy0GLsoObrc7UdcB5/
         uwFqDa/q3I+3geOBkZhilM88WnbIkdCtawa+vai6k3JOueUkLx1RpZstxbi38sQ/AHtE
         Z6RQt/gPRq4XH5n3nKPF/WjvrQrg1ERXAs+M81gWJDOXiyG64A/tDyYEO9fBr3rCzklm
         F+2Q==
X-Gm-Message-State: AOJu0Yw73rAXkY0r9UFcN0gmWVyMGxUuQdF8UcKWRZhCewxXviSWQINw
        /iEjQ2yZwfTGjZjOUw/6+CF3hg==
X-Google-Smtp-Source: AGHT+IGMmkdigA5BBQO6iDcRuVwj0b/wtfySuh+4OgLVGbZtxIXHhrSkmvb+qgLuaThXCX4M+JQBeg==
X-Received: by 2002:a05:6a20:914f:b0:14c:de3:95e8 with SMTP id x15-20020a056a20914f00b0014c0de395e8mr611901pzc.52.1693507336493;
        Thu, 31 Aug 2023 11:42:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v25-20020aa78099000000b0068b1149ea4dsm1590960pff.69.2023.08.31.11.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 11:42:15 -0700 (PDT)
Date:   Thu, 31 Aug 2023 11:42:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] scsi: target: Replace strlcpy with strscpy
Message-ID: <202308311141.612BF8D@keescook>
References: <20230831143638.232596-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831143638.232596-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Aug 31, 2023 at 02:36:38PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
> v3:
>  * Address readability comment.
> 
> v2:
>  * Replace all instances of strlcpy in this file instead of just 1.
>  * https://lore.kernel.org/all/20230830210724.4156575-1-azeemshaikh38@gmail.com/
> 
> v1:
>  * https://lore.kernel.org/all/20230830200717.4129442-1-azeemshaikh38@gmail.com/
> 
>  drivers/target/target_core_configfs.c |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
> index 936e5ff1b209..d5860c1c1f46 100644
> --- a/drivers/target/target_core_configfs.c
> +++ b/drivers/target/target_core_configfs.c
> @@ -1392,16 +1392,16 @@ static ssize_t target_wwn_vendor_id_store(struct config_item *item,
>  	/* +2 to allow for a trailing (stripped) '\n' and null-terminator */
>  	unsigned char buf[INQUIRY_VENDOR_LEN + 2];
>  	char *stripped = NULL;
> -	size_t len;
> +	ssize_t len;
>  	ssize_t ret;
> 
> -	len = strlcpy(buf, page, sizeof(buf));
> -	if (len < sizeof(buf)) {
> +	len = strscpy(buf, page, sizeof(buf));
> +	if (len > 0) {
>  		/* Strip any newline added from userspace. */
>  		stripped = strstrip(buf);
>  		len = strlen(stripped);
>  	}
> -	if (len > INQUIRY_VENDOR_LEN) {
> +	if (len < 0 || len > INQUIRY_VENDOR_LEN) {

Agh, sorry I missed this before: the first "if" needs to be "len >= 0"
otherwise this:

        ret = target_check_inquiry_data(stripped);

will be passing a NULL pointer...

-- 
Kees Cook
