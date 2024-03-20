Return-Path: <linux-scsi+bounces-3305-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB7A880991
	for <lists+linux-scsi@lfdr.de>; Wed, 20 Mar 2024 03:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94322840EF
	for <lists+linux-scsi@lfdr.de>; Wed, 20 Mar 2024 02:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAAE8830;
	Wed, 20 Mar 2024 02:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K7CsGyc3"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1BB7489
	for <linux-scsi@vger.kernel.org>; Wed, 20 Mar 2024 02:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710901429; cv=none; b=kvbbexzvWBdIoRLvehlr7SO9gIKj9dSFAhVaIWdujnHhJWykSqxfNjyFie3CXrIgXMo4BslreQS5d2t9+TQvv9PmTb/bXl9Oz17tkBXQ7jfEm07miLwzpliWI0RrrAruKpH0DaAyL90E7kEHAnQXYGzFCAcBkd6ARzC4w/QUCMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710901429; c=relaxed/simple;
	bh=CrQnqMvDrnyVSQPS+ineAuhvgXfu0NjUynu4z2aN4AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STp6/7l7IYflx6psCpKLKQd1+jsuaxXwuN3I8OBk3Eu1hqhq4Er9tnAxcFqpwfFZyVEVzeOjgVAnKy/JQpgxvPZsThApuC2wbx1u+vvD8TnjFHMHh/YCFeN6xZ5ufVqbXy5c/wWSmzXD2dBDxb2y3RLbPcLcZXkjaIOb7zSO1W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K7CsGyc3; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c36ecdb8cdso2860776b6e.1
        for <linux-scsi@vger.kernel.org>; Tue, 19 Mar 2024 19:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710901425; x=1711506225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kSoI/pMAjXfzjKvOOwcZSweV3DuyNeX7z58Nwuw7Wpw=;
        b=K7CsGyc3aYxi0sOmgM/BWzDnZeGgeV9gh5fpahqhAhzr1XOiy/j8CM89T/mbV2SZwt
         LpM0PBMuzXaw6bA5Alw6J69PS5s7BBbTdKgfySoVSG8cupZCj6JXhz9kEqsC/ANwgURj
         fgLUraLgdF0BmNRt7/Y/CKcwq8ABNUHzArcmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710901425; x=1711506225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSoI/pMAjXfzjKvOOwcZSweV3DuyNeX7z58Nwuw7Wpw=;
        b=VQTfOai/lPP5QVtC03dMxngKEho3xA+CwKMPWxxRq+WuqrfTnsZ0AsQ5oUWFuLBub9
         GcOqtoauFc4uIFAdPSKSW9bw3Hmcms0wco9mw1BidyfVgAcXFZxz7Cmi26t6xZAHA3mk
         EbCSoWS7ZDm7Qb5wGUtK5ul204i5q9V0kGwTbqs7xN9TBhuSUgCWZKB9A4gxVInEB4mp
         DVuq1LBiE9oGd0+DRpWnAUcBJeMNFrYd2j48xvUPwGFqs/h/fMITSwtvv0UeAptLRbf8
         G+2IMSzlc1BA7Xgq3245THv3oBlBBkZPSYeVw6KRCzuB8niz29NPensfec4KHIriT9PN
         Q2TQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+4HKNSLdF7Ywusi2suvIBgsnTXx8i3C1MFO1wfVsk9hxKVbexPMEBK6kS0DbnChoRXItdou4hF70VyRQThUob4T0MCO7PW/cKWA==
X-Gm-Message-State: AOJu0YzIX4SPH6w21CsR7fimzAsVute5zricn6mKxRQO36FbF1iPK7Yv
	4cvrMJgesUkV9Ldy2GX/2jBlV5byQcdcLpe0tf5SNu/rKFXeE/C7dYqTzzYvlw==
X-Google-Smtp-Source: AGHT+IGfIzj94Z+izVHNRIFrqtFeuAGI7P+/V72cDrVR393SoALZgULeL61JOX8n8bdJC1wE8P/cYQ==
X-Received: by 2002:a05:6808:3998:b0:3c3:84a5:468c with SMTP id gq24-20020a056808399800b003c384a5468cmr1296827oib.33.1710901425362;
        Tue, 19 Mar 2024 19:23:45 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x28-20020a056a000bdc00b006e78124ad83sm401940pfu.110.2024.03.19.19.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 19:23:44 -0700 (PDT)
Date: Tue, 19 Mar 2024 19:23:43 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: target: core: replace deprecated strncpy with
 strscpy
Message-ID: <202403191908.1B6BBA3@keescook>
References: <20240318-strncpy-drivers-target-target_core_transport-c-v1-1-a086b9a0d639@google.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-strncpy-drivers-target-target_core_transport-c-v1-1-a086b9a0d639@google.com>

On Mon, Mar 18, 2024 at 10:07:50PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect p_buf to be NUL-terminated based on the callsites using these
> transport_dump_* methods because they use the destination buf with C-string
> APIs like strlen() and sprintf().
> 
> 		memset(buf, 0, VPD_TMP_BUF_SIZE);			\
> 		transport_dump_vpd_ident_type(vpd, buf, VPD_TMP_BUF_SIZE); \
> 		if (len + strlen(buf) >= PAGE_SIZE)			\
> 			break;						\
> 		len += sprintf(page+len, "%s", buf);			\
> 
> We also do not require the NUL-padding behavior that strncpy() provides
> because we are manually setting the entire buffer to NUL, rendering any
> future padding redundant.
> 
> Let's use strscpy() as it guarantees NUL-termination and doesn't
> NUL-pad ( and isn't deprecated :>] ). Note that we can't use the more
> idiomatic strscpy() usage of strscpy(dest, src, sizeof(dest)) because
> the size of the destination buffer is not known to the compiler. We also
> can't use the new 2-arg version of strscpy() from Commit e6584c3964f2f
> ("string: Allow 2-argument strscpy()")
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Hm, this actually fixes potential over-reads and potential memory content
exposures (in the face of malicious/weird hardware) since p_buf_len
appears to always be sizeof(p_buf) in callers, which means the old use
of strncpy() could have left the string unterminated.

In practice I would assume it's not a problem, but, for example, here's
a place where the 254 p_buf_len could run out when doing the sprintf:

#define VPD_TMP_BUF_SIZE                      254
...
#define INQUIRY_VPD_DEVICE_IDENTIFIER_LEN       254
...
struct t10_vpd {
        unsigned char device_identifier[INQUIRY_VPD_DEVICE_IDENTIFIER_LEN];
	...
};
...
int transport_dump_vpd_ident(..., unsigned char *p_buf, int p_buf_len)
{
	...
        unsigned char buf[VPD_TMP_BUF_SIZE];
	...
                snprintf(buf, sizeof(buf),
                        "T10 VPD ASCII Device Identifier: %s\n",
                        &vpd->device_identifier[0]);
	...
        if (p_buf)
                strncpy(p_buf, buf, p_buf_len);	// may write 254 chars and no NUL
	...
}
...
        unsigned char buf[VPD_TMP_BUF_SIZE];
	...
	memset(buf, 0, VPD_TMP_BUF_SIZE);
        transport_dump_vpd_ident_type(vpd, buf, VPD_TMP_BUF_SIZE);
        if (len + strlen(buf) >= PAGE_SIZE)
		break;
	len += sprintf(page+len, "%s", buf);	// may expose stack memory following "buf"


So, yes, please!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/target/target_core_transport.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
> index 73d0d6133ac8..3311eb87df6d 100644
> --- a/drivers/target/target_core_transport.c
> +++ b/drivers/target/target_core_transport.c
> @@ -1112,7 +1112,7 @@ void transport_dump_vpd_proto_id(
>  	}
>  
>  	if (p_buf)
> -		strncpy(p_buf, buf, p_buf_len);
> +		strscpy(p_buf, buf, p_buf_len);
>  	else
>  		pr_debug("%s", buf);
>  }
> @@ -1162,7 +1162,7 @@ int transport_dump_vpd_assoc(
>  	}
>  
>  	if (p_buf)
> -		strncpy(p_buf, buf, p_buf_len);
> +		strscpy(p_buf, buf, p_buf_len);
>  	else
>  		pr_debug("%s", buf);
>  
> @@ -1222,7 +1222,7 @@ int transport_dump_vpd_ident_type(
>  	if (p_buf) {
>  		if (p_buf_len < strlen(buf)+1)
>  			return -EINVAL;
> -		strncpy(p_buf, buf, p_buf_len);
> +		strscpy(p_buf, buf, p_buf_len);

>  	} else {
>  		pr_debug("%s", buf);
>  	}
> @@ -1276,7 +1276,7 @@ int transport_dump_vpd_ident(
>  	}
>  
>  	if (p_buf)
> -		strncpy(p_buf, buf, p_buf_len);
> +		strscpy(p_buf, buf, p_buf_len);
>  	else
>  		pr_debug("%s", buf);
>  
> 
> ---
> base-commit: bf3a69c6861ff4dc7892d895c87074af7bc1c400
> change-id: 20240318-strncpy-drivers-target-target_core_transport-c-1950554ec04e
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

-- 
Kees Cook

