Return-Path: <linux-scsi+bounces-3844-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A878934B7
	for <lists+linux-scsi@lfdr.de>; Sun, 31 Mar 2024 19:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80CE71C23FE8
	for <lists+linux-scsi@lfdr.de>; Sun, 31 Mar 2024 17:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023C914A4F1;
	Sun, 31 Mar 2024 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NvrFdpa8"
X-Original-To: linux-scsi@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C3C148820;
	Sun, 31 Mar 2024 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903483; cv=fail; b=blzDidvp86FpsiMgo+NfOESTllOK+oZPn6DHBKtZ9DeoWWonIaytBnj5kYkmztjRAZzKS1IPy3YkKL87fL6OhP7UNi+i4NVcEPgsczP9nGgtduBCDa5kwLXOnG4gzc+O3oJu+AupNKLd7GvpfR9pE765TMvZAHZMeQDSeTy77wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903483; c=relaxed/simple;
	bh=FRIggP1YvWWV3rj+5WU1Cj2nMoZrQOSbDSPE/2jMC40=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QJ1ezQM4lyOeMXqzDqDnTP/cZCHY/W9eenM1z/m8cNH6hnouBQW2PJzg2L1TEP5ULQtGdgzngYCps1CeTmsnS8E83AnyRo1soKlfBQCcQREBsa879MpPJDK+S0fEGXcmOsIA/9U+Wf9j2ZdjWMCMNG6jv173YntGmNMbr5tPxvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=fail smtp.mailfrom=acm.org; dkim=fail (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NvrFdpa8 reason="signature verification failed"; arc=none smtp.client-ip=199.89.1.12; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 75AE22083B;
	Sun, 31 Mar 2024 18:44:40 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SOukA6gvJTJW; Sun, 31 Mar 2024 18:44:40 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id A2BA920896;
	Sun, 31 Mar 2024 18:44:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com A2BA920896
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 951E3800061;
	Sun, 31 Mar 2024 18:44:39 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:44:39 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:42 +0000
X-sender: <linux-kernel+bounces-125453-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-essen-01.secunet.de
X-ExtendedProps: BQBjAAoAB0imlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.197
X-EndOfInjectedXHeaders: 8414
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125453-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 2E8C020561
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748972; cv=none; b=imRoeGH5xl/m3DLOY7eCKUi7sprzA+ulAK+xbNkaFo1euIRtzYwvf3H4dlb7hLHe045/baQJ6cSZTbqo4R0pL5Iq5tUuITKZmKpTYKmEOpE+WR28JBkuvtdReqGO578erBnsayEER+gE0FpTbm2ORQ89kva6JAlO77OMhce+VuA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748972; c=relaxed/simple;
	bh=FRIggP1YvWWV3rj+5WU1Cj2nMoZrQOSbDSPE/2jMC40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJ5QcVIvIx+WnKyttgMHvYUQSlytXOS/S8mBHQM9Hu5SDmV6w8EaoneOQybOr2ia90h2pcCFuJ1qFgW2XHSKtq+rRo65+VyKB6HL7YMvKRvWoAljPnBIY1gT3eXWaHgGvBhyjfxIlHgqm5rqfVcUscZbRMZfQIZ/pKdrt3mA6mw=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NvrFdpa8; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711748967; x=1714340968; bh=FRIggP1YvWWV3rj+5WU1Cj2n
	MoZrQOSbDSPE/2jMC40=; b=NvrFdpa8pcA9cG+NIiJnuoeRqa/nPyhvnOtdKtLd
	WqtQBmfv5Xxa/dgMQibjBYWpMQXU99b6524nnJyI8pR/Q1lbHWv1wXDr0wGHEsNl
	MnIwbJxL0DpSjF8SNG2GSqM2pNOxYN5q/Qkk1lddJBYelx8ypgvgvClefq1Mhl24
	H0gUpQPwbjzLn0glITC1tXYRk/I87LnqCSGaNh3fPf4IJnFVILDFulxZED+xaII6
	iBr5thFOG0UqWCqaTUezS8lMnQIdJZ40OgJlZMfMAGoHuNfec/Jn1agU0vb5QT1L
	9pHLevDlEg286EulZVVF/0rInaBlREIxgEGvUz37Avt+XA==
X-Virus-Scanned: by MailRoute
Message-ID: <ecd24b64-0f27-486b-a7aa-b4b51b7b16de@acm.org>
Date: Fri, 29 Mar 2024 14:49:21 -0700
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/11] scsi: ufs: core: Remove unnecessary wmb() prior
 to writing run/stop regs
To: Andrew Halaney <ahalaney@redhat.com>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
	<konrad.dybcio@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, "James
 E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Hannes Reinecke <hare@suse.de>, Janek Kotas
	<jank@cadence.com>, Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman
	<avri.altman@wdc.com>, Can Guo <quic_cang@quicinc.com>, Anjana Hari
	<quic_ahari@quicinc.com>
CC: Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240329-ufs-reset-ensure-effect-before-delay-v5-0-181252004586@redhat.com>
 <20240329-ufs-reset-ensure-effect-before-delay-v5-11-181252004586@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240329-ufs-reset-ensure-effect-before-delay-v5-11-181252004586@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


