Return-Path: <linux-scsi+bounces-900-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE8D80F973
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Dec 2023 22:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0BC1C20D6B
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Dec 2023 21:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB8E64144;
	Tue, 12 Dec 2023 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ixmc1hdX"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB74AF
	for <linux-scsi@vger.kernel.org>; Tue, 12 Dec 2023 13:34:11 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6ce939ecfc2so5588465b3a.2
        for <linux-scsi@vger.kernel.org>; Tue, 12 Dec 2023 13:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702416851; x=1703021651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BUBXCMgW8IRc4vkm7/izJLiVwvVVMNu8qOIh1J5boU8=;
        b=ixmc1hdXiCVXM3eKXWlbOid0djUpVNi7m3rTzzqaS2gqAibgXUqZmJ6x9vSXiezYPd
         k0J49kCxVo9svRTDafWND7Nh6BNt2FS6OEnGjrERvIdarplUylodWhf3Fkwozxmcr47S
         phJTsXk0VVCrq/Hi+V5RpiHlZozV7m8Z9qyMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702416851; x=1703021651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUBXCMgW8IRc4vkm7/izJLiVwvVVMNu8qOIh1J5boU8=;
        b=fiBkEQ9qE0OSi73ROuqVdsGtNc83qmlIDqnIjdcNZiACzBpnSlrfEA2FUYDkJ1hDQA
         +Fpoqns5CIYXUdwiXXlIjyauUjnERDPTeZL1qMKJFXaBqM4735MvpPmStXPpuAaNgJ+i
         LvONYqq13TiDaZ5zmMKsApuqfvjlnuE2XbGx+cDZnNpZdvWBnK8TlI5SsvMm8MlfTijL
         CEKa524fbIsczrmbQjI9sHuQ7YyvZoXfnevUq0NIhVT2zfeFjcGAaj4Ict89REWP+kuF
         ORQzFzRawMIOtVVTjXMEy0IH+K9s1IkjIkwNfQ6ZYfkKSEBfRufejA6PF7PknSc8cx6L
         8BBw==
X-Gm-Message-State: AOJu0YxR7xEudSy2q7uCXbEpvMAhof3LHIrHq94b8DHuhGalCQ63PbRU
	D/LQnEypxE9LLlcIDyiVC0Qz9Q==
X-Google-Smtp-Source: AGHT+IFjOA5OyEhfv3ZEaJ2ntXMaFYPXBjpMdJB7JxNYpSO1j7kBSU8jL07cqpqSKP1PenK7ylyWxA==
X-Received: by 2002:a05:6a00:8cb:b0:6ce:2e7b:55fa with SMTP id s11-20020a056a0008cb00b006ce2e7b55famr7820685pfu.39.1702416851123;
        Tue, 12 Dec 2023 13:34:11 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x3-20020a056a000bc300b006cea17d08ebsm8594307pfu.120.2023.12.12.13.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:34:10 -0800 (PST)
Date: Tue, 12 Dec 2023 13:34:10 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: fcoe: use sysfs_match_string over fcoe_parse_mode
Message-ID: <202312121330.2210A26@keescook>
References: <20231211-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-v1-1-73b942238396@google.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-v1-1-73b942238396@google.com>

On Mon, Dec 11, 2023 at 08:06:28PM +0000, Justin Stitt wrote:
> Instead of copying @buf into a new buffer and carefully managing its
> newline/null-terminating status, we can just use sysfs_match_string()
> as it uses sysfs_streq() internally which handles newline/null-term:
> 
> |  /**
> |   * sysfs_streq - return true if strings are equal, modulo trailing newline
> |   * @s1: one string
> |   * @s2: another string
> |   *
> |   * This routine returns true iff two strings are equal, treating both
> |   * NUL and newline-then-NUL as equivalent string terminations.  It's
> |   * geared for use with sysfs input strings, which generally terminate
> |   * with newlines but are compared against values without newlines.
> |   */
> |  bool sysfs_streq(const char *s1, const char *s2)
> |  ...
> 
> Then entirely drop the now unused fcoe_parse_mode, being careful to
> change if condition from checking for FIP_CONN_TYPE_UNKNOWN to < 0 as
> sysfs_match_string can return -EINVAL.
> 
> To get the compiler not to complain, make fip_conn_type_names
> const char * const. Perhaps, this should also be done for
> fcf_state_names.
> 
> This also removes an instance of strncpy() which helps [1].
> 
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Builds upon patch and feedback from [2]:
> 
> However, this is different enough to warrant its own patch and not be a
> continuation.
> 
> [2]: https://lore.kernel.org/all/9f38f4aa-c6b5-4786-a641-d02d8bd92f7f@acm.org/
> ---
>  drivers/scsi/fcoe/fcoe_sysfs.c | 26 ++++----------------------
>  1 file changed, 4 insertions(+), 22 deletions(-)

My favorite kind of insert/delete ratio! :)

> 
> diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
> index e17957f8085c..f9c5d00f658a 100644
> --- a/drivers/scsi/fcoe/fcoe_sysfs.c
> +++ b/drivers/scsi/fcoe/fcoe_sysfs.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/etherdevice.h>
>  #include <linux/ctype.h>
> +#include <linux/string.h>
>  
>  #include <scsi/fcoe_sysfs.h>
>  #include <scsi/libfcoe.h>
> @@ -214,25 +215,13 @@ static const char *get_fcoe_##title##_name(enum table_type table_key)	\
>  	return table[table_key];					\
>  }
>  
> -static char *fip_conn_type_names[] = {
> +static const char * const fip_conn_type_names[] = {
>  	[ FIP_CONN_TYPE_UNKNOWN ] = "Unknown",
>  	[ FIP_CONN_TYPE_FABRIC ]  = "Fabric",
>  	[ FIP_CONN_TYPE_VN2VN ]   = "VN2VN",
>  };
>  fcoe_enum_name_search(ctlr_mode, fip_conn_type, fip_conn_type_names)
>  
> -static enum fip_conn_type fcoe_parse_mode(const char *buf)
> -{
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(fip_conn_type_names); i++) {
> -		if (strcasecmp(buf, fip_conn_type_names[i]) == 0)
> -			return i;
> -	}
> -
> -	return FIP_CONN_TYPE_UNKNOWN;
> -}
> -
>  static char *fcf_state_names[] = {
>  	[ FCOE_FCF_STATE_UNKNOWN ]      = "Unknown",
>  	[ FCOE_FCF_STATE_DISCONNECTED ] = "Disconnected",
> @@ -274,17 +263,10 @@ static ssize_t store_ctlr_mode(struct device *dev,
>  			       const char *buf, size_t count)
>  {
>  	struct fcoe_ctlr_device *ctlr = dev_to_ctlr(dev);
> -	char mode[FCOE_MAX_MODENAME_LEN + 1];
>  
>  	if (count > FCOE_MAX_MODENAME_LEN)
>  		return -EINVAL;
>  
> -	strncpy(mode, buf, count);
> -
> -	if (mode[count - 1] == '\n')
> -		mode[count - 1] = '\0';
> -	else
> -		mode[count] = '\0';
>  
>  	switch (ctlr->enabled) {
>  	case FCOE_CTLR_ENABLED:
> @@ -297,8 +279,8 @@ static ssize_t store_ctlr_mode(struct device *dev,
>  			return -ENOTSUPP;
>  		}
>  
> -		ctlr->mode = fcoe_parse_mode(mode);
> -		if (ctlr->mode == FIP_CONN_TYPE_UNKNOWN) {
> +		ctlr->mode = sysfs_match_string(fip_conn_type_names, buf);
> +		if (ctlr->mode < 0) {

I think this needs to include FIP_CONN_TYPE_UNKNOWN to keep the logic
the same? (i.e. it could match the string "Unknown", so it would return
the enum value for that, 0 in this case.)

Otherwise, yeah, this looks good.

-Kees

>  			LIBFCOE_SYSFS_DBG(ctlr, "Unknown mode %s provided.\n",
>  					  buf);
>  			return -EINVAL;
> 
> ---
> base-commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
> change-id: 20231024-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-0e1dffe82855
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

-- 
Kees Cook

