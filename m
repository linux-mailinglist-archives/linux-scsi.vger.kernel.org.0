Return-Path: <linux-scsi+bounces-10723-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73C19EBF24
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Dec 2024 00:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D691605CC
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Dec 2024 23:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C20225A38;
	Tue, 10 Dec 2024 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lHLPUz2e"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9903225A20
	for <linux-scsi@vger.kernel.org>; Tue, 10 Dec 2024 23:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733872473; cv=none; b=LCto6sq13Rlg6XiT0sQWDUjWVZ0u8Hi1axfCRm/jiDLhl30xYchZqCy7KTA6GXMatS+MOdyEsHAvrZJxuY1BHR3kEe+lMUHeDMW87FxsujmwxsWZDnPrGAfKz0Fg49uYHD76dV1+dbr7Usst6FX9BnaWvSkj2JnlJEFojgj/Et4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733872473; c=relaxed/simple;
	bh=3x5TXPzh1y9Vn/sDwfrpCvwrmPWEU4Z2YUHlCg/j1L4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsOs3wuDNmFmENkw6dUCC/qdkzqrEjxJCPF+cVMDB6EKuuI3hcZGEW2DV8kzw0LNZzGN+QFQ1LGBbWW9uYILZvXIQaBSlInKAxCvzMidAd1LEsoHut7samaVE0yhYeYsVRdWYmKfCDVnhD4zhMOs77OvEjKAC/Ho0d0/71IpFpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lHLPUz2e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BACgYKe014016
	for <linux-scsi@vger.kernel.org>; Tue, 10 Dec 2024 23:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PS7l0d33ZO6FBTryro+pjfe77l6D5X7/u/fq40BAyts=; b=lHLPUz2eKaNKUox1
	Ub5dhzdNAOoET8wh+maovCNDPMy6t9eby0VQUopQ/MZLa6olLQwy25+UgpQb8ro5
	VlaMWxZAETVnPKvlzO71jszhSUnevwYHdclz20ywMSlVphBPRa3l4C1hylijowi6
	Bk3QIOrIkCQ+2EOFX/Sdw0b2IpZEpF1kH2IJP81FgU3tYlzhsESrVAf/9ob9ocEp
	ghZvyaVc4lOYnIZDKgvxAUu3jssYTEMSXzRSX3MWUGVMwFilQ0CtwOxrY/ufjUY6
	/bXYCyJGZj10oYxR+tKJcKdW/M9cw92yDO1a0dD+j2PcKvi8rQ2zfcQIOo+BmC3o
	GqzWSw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43dvyap9c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-scsi@vger.kernel.org>; Tue, 10 Dec 2024 23:14:30 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2efa0eb9dacso2761246a91.1
        for <linux-scsi@vger.kernel.org>; Tue, 10 Dec 2024 15:14:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733872469; x=1734477269;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PS7l0d33ZO6FBTryro+pjfe77l6D5X7/u/fq40BAyts=;
        b=ppL3C8nWOChbs5xrBvlYJDAGMMHC6OwSV7q/mi3Fp9VqwcG2hMSMHmwXj4cvkd7JVF
         92T1/8/DfzoAvqgClmtkk9v/5DGW4kf6BmqLMUSq/8MYINpAUMt9G66zED0j/jWVUmCM
         gCIV2Pnn1ZKoMcPM5S8miXcPWA64sjSyqymRAb6x1+YB3ZkePSy6BrgJnItHJ4ljdEcc
         F/kLQcJdXZxdsdAEAM+vazVdoBfgcKwjFcbgLUIPlkYlkU8m82BIKQghW5PHEIhz90gP
         YiPWHIh4Qz1SqKkNmCuntVsjcOBfSj2Owku1Rl/I55fH8nsVYSHGYxDYztmueby12EQe
         qNUw==
X-Forwarded-Encrypted: i=1; AJvYcCVbblY/NqqzP5XB+cSZsTrP1JI+vQ5WHzEbZzrx3RHizDnM+eJdz/pbkp+9J0aKd2PqpEkjtA4kF2u1@vger.kernel.org
X-Gm-Message-State: AOJu0YwhI0qoNse67VSFSQzumOnwrVYCJeNTuXiguKM8d5VrjNOVNoUZ
	PoAmd36Rs9E8xSNAo6IIluC1i9e6OR52U0pTEXAXP+85ZW6zEe62Hndoj78QVtpe9Xcxper5lKX
	Kq6PFu58nSGeqQbP9hxPZyu7twGqLhaDekaGghRhiN/L8Umms++TcP6Wzmyt9
X-Gm-Gg: ASbGncs+UCczHQUea7O7W4KoMdpUuyqk6oDTAb0NetkGetPKLQypb/gQLHdxG/zpaEa
	4pAm84wDVbCyWoPOgUyjaPkRL5m2iHfS33m9lIpyfmIbX46mDjTfN/uXR/BLDSI7TSXPvaDYAnx
	qfLWlHoY6PKBLhvADg+WeFlonrSjyWliRuSwcyyVJc9ULKLchEMJDmqGAD22WTZgj77G4DSW9oT
	lUGAfFzEykHXLvkQxjQ8dsyubW52RxjR185E22yOI5ZM75VKiGdT0Qb3Vi8N5JcErtl5P4sg1el
	PBcIRdXOrdxc45qzqXqXrkzob1gzucI3Xjd4d+0rNiMVAXw=
X-Received: by 2002:a17:90b:2d81:b0:2ee:dd9b:e402 with SMTP id 98e67ed59e1d1-2f127fc6f84mr1521912a91.12.1733872468854;
        Tue, 10 Dec 2024 15:14:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBBY7t9Ty+FaaMWRfRUoSNUm5Sp5vin1MZzPlySUpMdXEhND47a5JS9XP+rCTHee3d0P0EmA==
X-Received: by 2002:a17:90b:2d81:b0:2ee:dd9b:e402 with SMTP id 98e67ed59e1d1-2f127fc6f84mr1521809a91.12.1733872468344;
        Tue, 10 Dec 2024 15:14:28 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef779bace5sm7621993a91.31.2024.12.10.15.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 15:14:27 -0800 (PST)
Message-ID: <315e9178-5b10-4de0-bdcf-7243e0e355bb@oss.qualcomm.com>
Date: Tue, 10 Dec 2024 15:14:22 -0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/19] Converge on using secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King
 <linux@armlinux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>,
        Oded Gabbay <ogabbay@kernel.org>,
        Lucas De Marchi
 <lucas.demarchi@intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand <shailend@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Catalin Marinas
 <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Louis Peens <louis.peens@corigine.com>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, cocci@inria.fr,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-mm@kvack.org,
        linux-bluetooth@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org,
        live-patching@vger.kernel.org, linux-sound@vger.kernel.org,
        oss-drivers@corigine.com, linuxppc-dev@lists.ozlabs.org,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
References: <20241210-converge-secs-to-jiffies-v3-0-ddfefd7e9f2a@linux.microsoft.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241210-converge-secs-to-jiffies-v3-0-ddfefd7e9f2a@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WbiJpxLIidUHfu-lSpVh29AAfS-kUkli
X-Proofpoint-ORIG-GUID: WbiJpxLIidUHfu-lSpVh29AAfS-kUkli
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxlogscore=805 mlxscore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412100166

On 12/10/2024 2:02 PM, Easwar Hariharan wrote:
> This is a series that follows up on my previous series to introduce
> secs_to_jiffies() and convert a few initial users.[1] In the review for
> that series, Anna-Maria requested converting other users with
> Coccinelle. [2] This is part 1 that converts users of msecs_to_jiffies()
> that use the multiply pattern of either of:
> - msecs_to_jiffies(N*1000), or
> - msecs_to_jiffies(N*MSEC_PER_SEC)
> 
> where N is a constant, to avoid the multiplication.
> 
> The entire conversion is made with Coccinelle in the script added in
> patch 2. Some changes suggested by Coccinelle have been deferred to
> later parts that will address other possible variant patterns.
> 
> CC: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

I have the same question as before: How do you expect these to land?
Do you now have a maintainer who will take all of them?
Or do you want individual maintainers to take the ones applicable to them?

/jeff

