Return-Path: <linux-scsi+bounces-67-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E0A7F4FD4
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Nov 2023 19:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15307281592
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Nov 2023 18:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45D95CD35
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Nov 2023 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0EE10CB;
	Wed, 22 Nov 2023 09:51:31 -0800 (PST)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ce627400f6so44625ad.2;
        Wed, 22 Nov 2023 09:51:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700675490; x=1701280290;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cnb1eQygLiPupCdQ+B3C7i5AAJxIHJuBeS7g4lwHVHs=;
        b=PQWFg5swe7MV6/aSo4TOk0acI8ggkc7ChLnj8PpHkjhiVpG90yqEbz1M3efcslm2/6
         bbcKS8cS6IDgvkQac4Uiybsd7sJna7RM6wlY7fl8pz093C7FE941wbmhi7+MKbApO9gG
         OJUAjj/8gi4OwA3H/6ddsja37vPtAyXTSVWcQ0RzY05mpJk9Sx2MM1TA6n+EvsTo8EOT
         yabUsE3BxHxDA9l/5Y9B5GG1LWVYdy2SThVkuF/YJx+ZFcyxRk+JAz7PGUE09Uf0/JiA
         HnGiQhgAMzgSbr6DochjkfIHh1WaPo7bxR6UFfbp9Wm6ZKLZaeIKmiZL9JkNbBPEscqd
         7Paw==
X-Gm-Message-State: AOJu0YzglGxr9n5yYhko19+swVqq6xo1shM88JAanA06holpJIGyuqC1
	TXau9CQubL1NNK9Dcp1Lx3Y=
X-Google-Smtp-Source: AGHT+IFy7SY86uCLGlmPSFf6NOxrm6oFa4KHKpx+UZkBnOz0qPS87nWSJ0dpDE2svf8pG2yO0e2AGg==
X-Received: by 2002:a17:902:f7c1:b0:1cc:5f51:b1ed with SMTP id h1-20020a170902f7c100b001cc5f51b1edmr2546273plw.47.1700675490304;
        Wed, 22 Nov 2023 09:51:30 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:9d34:90db:9557:9413? ([2620:0:1000:8411:9d34:90db:9557:9413])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902690800b001c76fcccee8sm9989507plk.156.2023.11.22.09.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 09:51:29 -0800 (PST)
Message-ID: <fbc51bf1-3c4f-4575-a148-65fcfee1a8fe@acm.org>
Date: Wed, 22 Nov 2023 09:51:27 -0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] scsi: ufs: core: Add UFS RTC support
Content-Language: en-US
To: Bean Huo <beanhuo@iokpp.de>, avri.altman@wdc.com,
 alim.akhtar@samsung.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
 mani@kernel.org, quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
 beanhuo@micron.com, thomas@t-8ch.de
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 mikebi@micron.com, lporzio@micron.com
References: <20231122172512.103748-1-beanhuo@iokpp.de>
 <20231122172512.103748-3-beanhuo@iokpp.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231122172512.103748-3-beanhuo@iokpp.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/23 09:25, Bean Huo wrote:
> Given that the RTC has been a standard feature since UFS Spec 2.0, and qTimestamp was introduced
> in UFS Spec 4.0, the majority of UFS devices currently on the market rely on RTC. Therefore, it
> is advisable to continue supporting RTC in the Linux kernel. This ensures compatibility with the
> prevailing UFS device implementations and facilitates seamless integration with existing hardware.
> By maintaining support for RTC, we ensure broad compatibility and avoid potential issues arising
> from deviations in device specifications across different UFS versions.

Patch descriptions should be 75 characters wide. See also
Documentation/process/submitting-patches.rst.

Thanks,

Bart.


