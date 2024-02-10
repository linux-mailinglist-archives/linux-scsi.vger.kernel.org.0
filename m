Return-Path: <linux-scsi+bounces-2344-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B71E8502E7
	for <lists+linux-scsi@lfdr.de>; Sat, 10 Feb 2024 08:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA831C215EA
	for <lists+linux-scsi@lfdr.de>; Sat, 10 Feb 2024 07:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED1327447;
	Sat, 10 Feb 2024 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kKyHYZ5e"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DCE2135B
	for <linux-scsi@vger.kernel.org>; Sat, 10 Feb 2024 07:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548774; cv=none; b=Cpm9H7vH9r22hhHNtOSkkbu4clmXlj7oa0jOP9DdeUswQ0JDXEEwWqS0/z4mlzhKs698HnDJ+3pbP3blMwgWxeLD6VQo0FXGoTPVtSDfUeJhf+ndcCNsHmMxP9E32aD33zUgs440C2SAjxEZfRb4RaQygitbASNJQgIBODZthYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548774; c=relaxed/simple;
	bh=u5aSZ75Pq8bWKdAw+W5D98hsJd3DcnLzNDzyk+f2erw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6xOYEpK9xEaevlW/AYi8TfVRp13Uus/Wg7Diu77sN3nqDDBQ1V1KVdgHrP11jXoDUJDS/aCwH1h7tW/O4j/AqDLnFcDwEjZGuNblTgo1Dapi+0N66WvndfOIY7Q7/Tx9R5y3p7MUnU9fd9PjhtEC8ZuYo5NhlzOW+bqBtqt7PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kKyHYZ5e; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e0507eb60cso1168331b3a.3
        for <linux-scsi@vger.kernel.org>; Fri, 09 Feb 2024 23:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707548772; x=1708153572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=em67GxBbJuke46FxIVNprDBwCwRfGg+vWznk7EN7Egw=;
        b=kKyHYZ5eeIdA83nCjq0dmer32Bb/zO2dl9RBubi5d8+1t0CaUxGnvTKtL04UeBF/9n
         LvsSqnA2KLQpZx3tBC+UhibOX+/FsckbdH0/ETJPp8NwHlclBhJ+qyyO7p1tc+ZTfM4i
         YHB900v77Q5hgYZtbVzdXnNYqhwT/b+P6mT88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548772; x=1708153572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=em67GxBbJuke46FxIVNprDBwCwRfGg+vWznk7EN7Egw=;
        b=Btp8thITi0q0aBc++JiVj3linefqiMGZ/0wCKa3BcDHXlkSCrNSJ7ufVbzowwoxZ+0
         SM3zFPRa6+QniL5cIrRs9wl+pBpJgGjXZMKD+amDGvX2c2ScNwLjJTHLfkdN6rp36/S0
         UvEMi+fP25pGx2Up4teuTJUkC/2cHC3KyJMfpZBv9O0pKwj4WsGGR4fETSK6t0Q9jI51
         chO7hYTxVoybj987S3sI25wnWCw/F3Z0BtVWsy9t404V2pbmFtWG0wHlLKOnxTfqWif5
         TA+mMUI8Qw5SmkYEe8eAFMA3tSHz9tvgTkkld/XtSCje3fZy1fTHqRiywvinKLFsbRqZ
         QsNw==
X-Gm-Message-State: AOJu0Yy1MKOly67JTzuM/jW2P+aHJJSmS9crooJ52DLFSb+fAydQVnPw
	yC9A3/0PTVkNeCgwT6LxghmlacsDpiWaK0PqLz3aAk/rbzBtR4v1beXpm7wJNQ==
X-Google-Smtp-Source: AGHT+IHx3OTjaj9e/ai0siFXXhhRi5V6Ipwp/Yg51xN2WOA5mw3DC614dbutjRabn5uMl9GXncQcBA==
X-Received: by 2002:aa7:8697:0:b0:6d9:b4e6:ffb with SMTP id d23-20020aa78697000000b006d9b4e60ffbmr1567996pfo.0.1707548771984;
        Fri, 09 Feb 2024 23:06:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUG+I9XVE2iar9wTcJDEpMQSTKjIsjT/JLUzg4t3u+93v91KJ4RDRW4qfBv0vgt5g3FgmiCG6Xf+QLvPa251j46JgK1Fpvcp6haSZHhuYtc+QKc9lP/5kMxWBf6DopW9P914Hkl4qU1oJwbvi0KetwpMnfYMUqVNFGHMsrJgt2ra6HN3qSofJDCDzfMrtbSDSkSEZPbGEF41kCZ1Q==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m8-20020aa78a08000000b006e05cb7fd1fsm1618491pfa.164.2024.02.09.23.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 23:06:11 -0800 (PST)
Date: Fri, 9 Feb 2024 23:06:10 -0800
From: Kees Cook <keescook@chromium.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 06/10] scsi: aha1542: Replace snprintf() with the safer
 scnprintf() variant
Message-ID: <202402092303.F5F31A17@keescook>
References: <20240208084512.3803250-1-lee@kernel.org>
 <20240208084512.3803250-7-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208084512.3803250-7-lee@kernel.org>

On Thu, Feb 08, 2024 at 08:44:18AM +0000, Lee Jones wrote:
> There is a general misunderstanding amongst engineers that {v}snprintf()
> returns the length of the data *actually* encoded into the destination
> array.  However, as per the C99 standard {v}snprintf() really returns
> the length of the data that *would have been* written if there were
> enough space for it.  This misunderstanding has led to buffer-overruns
> in the past.  It's generally considered safer to use the {v}scnprintf()
> variants in their place (or even sprintf() in simple cases).  So let's
> do that.

It may be better to do a global replace of snprintf() where the return
value is not used.

$ git grep '\bsnprintf\b' | grep -v = | wc -l
6400

There's plenty of work to do to remove just the ones taking the result:

$ git grep ' = snprintf\b' | wc -l
764

Regardless,

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Link: https://lwn.net/Articles/69419/
> Link: https://github.com/KSPP/linux/issues/105
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> ---
>  drivers/scsi/aha1542.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/aha1542.c b/drivers/scsi/aha1542.c
> index 9503996c63256..b5ec7887801a5 100644
> --- a/drivers/scsi/aha1542.c
> +++ b/drivers/scsi/aha1542.c
> @@ -772,7 +772,7 @@ static struct Scsi_Host *aha1542_hw_init(const struct scsi_host_template *tpnt,
>  		goto unregister;
>  
>  	if (sh->dma_channel != 0xFF)
> -		snprintf(dma_info, sizeof(dma_info), "DMA %d", sh->dma_channel);
> +		scnprintf(dma_info, sizeof(dma_info), "DMA %d", sh->dma_channel);
>  	shost_printk(KERN_INFO, sh, "Adaptec AHA-1542 (SCSI-ID %d) at IO 0x%x, IRQ %d, %s\n",
>  				sh->this_id, base_io, sh->irq, dma_info);
>  	if (aha1542->bios_translation == BIOS_TRANSLATION_25563)
> -- 
> 2.43.0.594.gd9cf4e227d-goog
> 
> 

-- 
Kees Cook

