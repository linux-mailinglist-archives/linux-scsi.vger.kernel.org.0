Return-Path: <linux-scsi+bounces-159-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF53A7F8ECB
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Nov 2023 21:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB3ECB209CE
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Nov 2023 20:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3259E3064D
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Nov 2023 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwaZuJW2"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D71511B;
	Sat, 25 Nov 2023 11:36:54 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cba45eeaf6so746420b3a.1;
        Sat, 25 Nov 2023 11:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700941014; x=1701545814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7mSy6AtK6hcZt+Drsghr+39VrktzL88A/9JIeiEL+z4=;
        b=iwaZuJW2GUXS9UDq00Dm13eGfcW9k1x8UmXLOrpQEW+lVHyqS0UXauNZ+8eXMKLv7g
         2v3LeWfigKgi0Agp7JvV3sQmE/LaB08vceSWbVYl9a3WsYMt87zhPOPh9foIj95wM2ir
         frCrS5H/a/5W4QjVGtdT3yEgyAKKT6118yYHJbaPZMobKW7qLGQBBPApiWvv2j9PNh7x
         jKd8PgqTmu+zaDAm5/XSsV7DUi7JNL0wUZ7NY2Ok5+13s5jQk6j3a8w0uOV3GL7aGnF7
         hDP15D0rdyEsRWjxLfQKYKRPS3bnQGCcO9FQYvoojvHKCNXGjcHk5IrYX0TWlCG3xn8S
         /jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700941014; x=1701545814;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7mSy6AtK6hcZt+Drsghr+39VrktzL88A/9JIeiEL+z4=;
        b=w9p9/18CryGZ3LpfHGSmUsrBJI+l5qHeM3PCjGBv24QaL/uEYUoucbcJkSJd1SFQqG
         Rujrp1gv/Mq6uVODtQXek6WvjHpnnYtuypZrU6p/BDeEDbg/l68q0y0R5pNLsx15pLdL
         YSPf1G6trQ05MeJiF/yAA8E9AsXE7mjXMNToFPUuYUDEUD7bMu28Hl1Fq62mNzsH9PBX
         VCb54N/rjKgGaAeRHYeBKgi6Wx6XcF3kpOIEyFECW+2hkVPghNGHQ05GsP7efJYqeXVM
         +ku/lWo6Vcq2ZOBdCLkPL4KpP7JwVgojwo64kJLZEQBJEaqYyBfn3/NOiUW3LP0ibVbA
         25Wg==
X-Gm-Message-State: AOJu0YwiqnogIh/K23nG28t7Vw9ODlPlL6UsW67QLfPmtWN5odmYxic3
	qU30ZlE8UIkxFApoldnI5lE=
X-Google-Smtp-Source: AGHT+IFIYPXLZu1LFRAkgi5+zqXfm64WTV8o7ktHpacr0iImqsrY5DIuF+3qzI3NBYATNESj4FLsUw==
X-Received: by 2002:a05:6a20:7f8c:b0:18b:8158:dfa4 with SMTP id d12-20020a056a207f8c00b0018b8158dfa4mr9909038pzj.5.1700941013947;
        Sat, 25 Nov 2023 11:36:53 -0800 (PST)
Received: from [192.168.0.152] ([103.75.161.210])
        by smtp.gmail.com with ESMTPSA id x23-20020aa793b7000000b006cb638ba1aasm4610588pff.49.2023.11.25.11.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 11:36:53 -0800 (PST)
Message-ID: <aaf69d6b-55ea-44de-b6c4-0eddd2b0aa0c@gmail.com>
Date: Sun, 26 Nov 2023 01:06:48 +0530
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver: scsi: Fix warning using plain integer as NULL
Content-Language: en-US
To: oliver@neukum.org, aliakc@web.de, lenehan@twibble.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20231109215049.1466431-1-singhabhinav9051571833@gmail.com>
From: Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <20231109215049.1466431-1-singhabhinav9051571833@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/23 03:20, Abhinav Singh wrote:
> Sparse static analysis tools generate a warning with this message
> "Using plain integer as NULL pointer". In this case this warning is
> being shown because we are trying to initialize  pointer to NULL using
> integer value 0.
> 
> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> ---
>   drivers/scsi/dc395x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
> index c8e86f8a631e..d108a86e196e 100644
> --- a/drivers/scsi/dc395x.c
> +++ b/drivers/scsi/dc395x.c
> @@ -1366,7 +1366,7 @@ static u8 start_scsi(struct AdapterCtlBlk* acb, struct DeviceCtlBlk* dcb,
>   			"command while another command (0x%p) is active.",
>   			srb->cmd,
>   			acb->active_dcb->active_srb ?
> -			    acb->active_dcb->active_srb->cmd : 0);
> +			    acb->active_dcb->active_srb->cmd : NULL);
>   		return 1;
>   	}
>   	if (DC395x_read16(acb, TRM_S1040_SCSI_STATUS) & SCSIINTERRUPT) {
Hello maintainers, any reviews or comments on this.

Thank You,
Abhinav Singh

