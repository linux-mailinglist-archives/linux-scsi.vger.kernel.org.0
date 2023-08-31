Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD9F78E266
	for <lists+linux-scsi@lfdr.de>; Thu, 31 Aug 2023 00:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbjH3WjV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 30 Aug 2023 18:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343888AbjH3WjU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 30 Aug 2023 18:39:20 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997BFCDA
        for <linux-scsi@vger.kernel.org>; Wed, 30 Aug 2023 15:38:54 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-54290603887so239429a12.1
        for <linux-scsi@vger.kernel.org>; Wed, 30 Aug 2023 15:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693435134; x=1694039934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YomMerHxi5chwbf+vSfxIXZNG+5ikh/ZEAP8HjV/WpE=;
        b=Z2SFLu0dUWMWp4V6Hc5r+JJ17A96XygW3BCDRQqCbharqzUnfYaH7X74cEtmQ9Q9sU
         XmUZGbX8QFc22NMddBLHiFDiCgRhvyQmaAlRXwbkh+K9EgMxzAWSttdjtjnFa4dNL3Hg
         +/qTxkhAAfReRQ8b+nXtUijyhq/rXTkdleAaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693435134; x=1694039934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YomMerHxi5chwbf+vSfxIXZNG+5ikh/ZEAP8HjV/WpE=;
        b=FMYu1LYKolHIQ1LxRAbxkKiS6lX/0N5imYk0UWUn+SY/yqjNYnMmQ/rkWqRAwwvDO2
         cf7PneEVZZVbczdmhLordURT8HJ3UqtSccWhcu2HP8MQvERjxxC6pXWamlrKuAv+dftw
         xi+TmR8RXaCGBMhHuRzIcyjgo2JGiOXwWSzsOeWsGZUc1pKfJCQiHb5tmNk/5j+S5wIB
         3fCqjBCTIQFxwZlPr/7S9qFR5ak9FlL3YU9lHEsgeCmJxbfgefurNJg5TU8N8nw6mAf4
         xODd/oCSOrIffUF5jyRxdf17o5dzXEEWVjZbLoCcuRqKZl6z6DauMgFh7knW7UhmNKrN
         wuzQ==
X-Gm-Message-State: AOJu0YwBmNk3RVtaS59ect8aZuAykHJ+DQOEgqxWUplj3SIMCRzJ6gx4
        kWw6YRXuJdLaL8p1dRPMW7I4Gg==
X-Google-Smtp-Source: AGHT+IF+ryOPlq201gHOojr77+5qokJqMKiAi/Tu3pX1ZAe2um3TaACN8YRegkwzzG6rZvmRx+5VKg==
X-Received: by 2002:a05:6a20:9691:b0:131:b3fa:eaaa with SMTP id hp17-20020a056a20969100b00131b3faeaaamr2962535pzc.61.1693435134082;
        Wed, 30 Aug 2023 15:38:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e22-20020aa78256000000b0068c676f1df7sm81729pfn.57.2023.08.30.15.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 15:38:53 -0700 (PDT)
Date:   Wed, 30 Aug 2023 15:38:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: target: Replace strlcpy with strscpy
Message-ID: <202308301537.88398E90BB@keescook>
References: <20230830210724.4156575-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830210724.4156575-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Aug 30, 2023 at 09:07:24PM +0000, Azeem Shaikh wrote:
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
> v2:
>  * Replace all instances of strlcpy in this file instead of just 1.
> 
> v1:
>  * https://lore.kernel.org/all/20230830200717.4129442-1-azeemshaikh38@gmail.com/
> 
>  drivers/target/target_core_configfs.c |   27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
> index 936e5ff1b209..10a22a428267 100644
> --- a/drivers/target/target_core_configfs.c
> +++ b/drivers/target/target_core_configfs.c
> @@ -1392,16 +1392,15 @@ static ssize_t target_wwn_vendor_id_store(struct config_item *item,
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
> -		len = strlen(stripped);
>  	}
> -	if (len > INQUIRY_VENDOR_LEN) {
> +	if (len < 0 || strlen(stripped) > INQUIRY_VENDOR_LEN) {
>  		pr_err("Emulated T10 Vendor Identification exceeds"
>  			" INQUIRY_VENDOR_LEN: " __stringify(INQUIRY_VENDOR_LEN)
>  			"\n");

I would find these more readable if the "len = strlen" were left and the
final "if" becomes:

	if (len < 0 || len > INQUIRY_VENDOR_LEN)

> @@ -1448,16 +1447,15 @@ static ssize_t target_wwn_product_id_store(struct config_item *item,
>  	/* +2 to allow for a trailing (stripped) '\n' and null-terminator */
>  	unsigned char buf[INQUIRY_MODEL_LEN + 2];
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
> -		len = strlen(stripped);
>  	}
> -	if (len > INQUIRY_MODEL_LEN) {
> +	if (len < 0 || strlen(stripped) > INQUIRY_MODEL_LEN) {
>  		pr_err("Emulated T10 Vendor exceeds INQUIRY_MODEL_LEN: "
>  			 __stringify(INQUIRY_MODEL_LEN)
>  			"\n");
> @@ -1504,16 +1502,15 @@ static ssize_t target_wwn_revision_store(struct config_item *item,
>  	/* +2 to allow for a trailing (stripped) '\n' and null-terminator */
>  	unsigned char buf[INQUIRY_REVISION_LEN + 2];
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
> -		len = strlen(stripped);
>  	}
> -	if (len > INQUIRY_REVISION_LEN) {
> +	if (len < 0 || strlen(stripped) > INQUIRY_REVISION_LEN) {
>  		pr_err("Emulated T10 Revision exceeds INQUIRY_REVISION_LEN: "
>  			 __stringify(INQUIRY_REVISION_LEN)
>  			"\n");
> --
> 2.42.0.283.g2d96d420d3-goog
> 
> 

-- 
Kees Cook
