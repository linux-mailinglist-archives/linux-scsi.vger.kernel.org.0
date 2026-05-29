Return-Path: <linux-scsi+bounces-24223-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOfMHhRqGWrGwQgAu9opvQ
	(envelope-from <linux-scsi+bounces-24223-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 29 May 2026 12:27:32 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21741600CC2
	for <lists+linux-scsi@lfdr.de>; Fri, 29 May 2026 12:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F15FD30156E1
	for <lists+linux-scsi@lfdr.de>; Fri, 29 May 2026 10:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95ED3AD516;
	Fri, 29 May 2026 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dd87647N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WRWqFAFS"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CAE363095
	for <linux-scsi@vger.kernel.org>; Fri, 29 May 2026 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050079; cv=none; b=dzhIlxfub2OcgX0AkBA85/D3Mwu+o82Cv1hkfcffWvkeyUN9tse9Lrnqj1Q64ESLcVTB4qmKMBSDkhxUcku1Masq8Tk0RvcOTijZ1z73mR/PrUig6Iha+Il8MTIM4D7vM4vWyP53kTtStT4LcT+LpVyHeDPsZCrSS06dV/qGY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050079; c=relaxed/simple;
	bh=ndUusg9JFbgd68j1eTv1bmkX0Kn6dQEUDp3MDmaHXto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYvUCPvwx0NFcrsFucPIO5+pq+fnEZmavmASPT4sXyyrg32+PjCUmelgrWhc2GTh0I/3U/cAoCz/7zw8Ks7aKP4M1uLwOOuNQQSiHBl5K5B7RAcxOWnFoTOA/dJbOFJJQY4W1RcOi1Qdl2I2koqrqwI0OAp5/HVmEqhIwSVJplY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dd87647N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WRWqFAFS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T7iT9v2258584
	for <linux-scsi@vger.kernel.org>; Fri, 29 May 2026 10:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bY3BUKoXhBcmrnKcds+pbnWPJ6sZ502U3G9uQXfVye8=; b=dd87647NwVW7mvi5
	ER9qZVxthtq7wjg+31amaChHKEc/eMzKWQK02toeu50OPRRua5aZ+SvMHNvNoRRi
	KVCtiuPdozYrhhnywIU2uYNY8CGga3MKfvH5BtYWXNVQUHT6u2XE/yHblHgM41U6
	kK32gBkar//1lDiGnqCDzEmwCXLe8H654vXtpX3b3OoU0AbB0AlD0uZHFlL8f4eY
	zgsHChGeIVf5+m1evwRQoavzP1fMoQfv/PEFH6aQfAgCnxOEPVZzlL0p+k85CbXH
	uhMm+eRMPi5IsiwDTNC014DTzYcwJa2xXvR+Wm/vE2tUgHEgpWl2AivzeAIPyWuQ
	8aM9XA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eety53k75-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-scsi@vger.kernel.org>; Fri, 29 May 2026 10:21:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bd6aeb3637so308868715ad.2
        for <linux-scsi@vger.kernel.org>; Fri, 29 May 2026 03:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780050076; x=1780654876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bY3BUKoXhBcmrnKcds+pbnWPJ6sZ502U3G9uQXfVye8=;
        b=WRWqFAFSHg8rRkLPJ/SYuw3i7VqLl08IppoAMpjSz2sBZdlG3uv740yVzmD5T0PEC4
         ny+mN4UpRrLI9jk8ZNE8ctZdYKuPhFgtlftdq5zXr4vrw2wSiO4jVvdb2x1aB5+aZDA3
         2b09s7G+Ruf3lhy1hQT8U2wHVB0B549HlcOyKzFFHcFiEOoIvKZXvjfLAnIdkw6rbQoe
         EQoP12aMfdFxyzi7r4yXgs8a2OYndJNlce/SZ7NF+4eV1qzDuiyEssILn2f4epJ4Hcxa
         StbO955EweeC94S9lt18NB3kLDppBqIpATScrQus6DdG1tJgXIoP7x5kRAv7C4pPGdtK
         1M+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780050076; x=1780654876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bY3BUKoXhBcmrnKcds+pbnWPJ6sZ502U3G9uQXfVye8=;
        b=O3Ios/G7ZAZH7FudnDZkjXRPZzXqvAu6lqWc/eSF9avd0sTpM6qCdmvJR/akAi5Ge0
         0RJYFqz+/W1dBAWhZQucDZb5G6tSK6feChBDDRoTMi9vQwVYTDelVzQGSK4F7p58CoOL
         zp71o+crhmiJEfYKybhuBOf0uRYDEASrK9k9A3yBtLXYidh8us80NefI2dJx8Ft9OE20
         3ownSdg6Z5Z4npoaVfSxjSi6yodC9kHb+Tjapb91+QOyy5BFfR1rilkLMNtCvC15yZGw
         TzyG7UFuzOyONE4OFMiEV4yMTYPsLvnOyrmgJ9luXtq09sqQQqgaw5p0uvbd3u30gvqY
         ORdA==
X-Gm-Message-State: AOJu0Yxrb+O9hG4FeV/DkmTvHdoF+v7cLkJsVc5tzE6fFcYFAk5SCR7V
	tx82WHKIjog+6eOnlNwA0nZS0spsBCTf9R1+TJWPwgILuHq1KSP/d3PUUEXoIHRAkn/IJ+EH/I1
	i/4xOMS1M9rrWABl+7J66eLQYLGCd29jUjn9aZ2F37jOYyOBB48ug5ZpO8QIdkKJO
X-Gm-Gg: Acq92OFMEUQUF/gQxb24faPBVlLWyEC8fcECTeQZ/jlH55cGo1gtwHtUCciYlkLlw/6
	MQmD4WF24YMEDuT0k8O8Y2Y13ky8JSLWbEQytT6PppP/8dMWwfiWGlH2Z6PMi+S7KDjOYKcr5gZ
	75wizrxmXT/Z8N3tQh2i1FAIExQLdcix27gKIm33JBv2wH1bVwbWsNwXZPKY3ZqbVdk1Bzhcu+v
	UTNGVq187h0bdYOcUk+wSMWZN+mmRSHiC8+78yhK/B0wzt2s3YpSpWr3SJvG7tuK3lNEq1Hdkc7
	+lhZPWLASfKENo3M+SdEGXB8MlwpSc5tDIjNxt0Bm/7ygarvg/iPQngfU7WOf6tch4Kr4fmIfX3
	ZxUOIcjHnV/kp70jJRMyvmgl91lRvGKOV/3xjvV0vtWlDz1mFG0yVSlenhcm22EoORQ4pcQGkRW
	JrNXD2smMVAVbh4BLF6RXFVA==
X-Received: by 2002:a17:903:2450:b0:2bd:eb0d:efb7 with SMTP id d9443c01a7336-2bf204dbe94mr29069655ad.1.1780050076323;
        Fri, 29 May 2026 03:21:16 -0700 (PDT)
X-Received: by 2002:a17:903:2450:b0:2bd:eb0d:efb7 with SMTP id d9443c01a7336-2bf204dbe94mr29069375ad.1.1780050075821;
        Fri, 29 May 2026 03:21:15 -0700 (PDT)
Received: from [10.133.33.247] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c3a5c8sm14000405ad.71.2026.05.29.03.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 03:21:15 -0700 (PDT)
Message-ID: <089e3959-08c3-4ed2-b0a3-3772d0ed7268@oss.qualcomm.com>
Date: Fri, 29 May 2026 18:21:11 +0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] scsi: ufs: core: Add support for static TX
 Equalization settings
To: Bean Huo <beanhuo@iokpp.de>,
        =?UTF-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?=
 <peter.wang@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "bvanassche@acm.org"
 <bvanassche@acm.org>,
        "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "quic_nitirawa@quicinc.com" <quic_nitirawa@quicinc.com>,
        "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "quic_rdwivedi@quicinc.com" <quic_rdwivedi@quicinc.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>
References: <20260529011421.462046-1-can.guo@oss.qualcomm.com>
 <20260529011421.462046-3-can.guo@oss.qualcomm.com>
 <1e432db04abc12c4109754788ab36a09111cf3e9.camel@mediatek.com>
 <7f2f9a0a-03e9-4a0e-ae57-2b0c557e029f@oss.qualcomm.com>
 <f2e1a0335a7c05ca7dbf48c17e9662e9695ded51.camel@mediatek.com>
 <0e3c4e21-0c54-42b5-8863-8604f1b698a8@oss.qualcomm.com>
 <e79510e02e1025f9a5c3dff0208cf63b22054bdb.camel@iokpp.de>
Content-Language: en-US
From: Can Guo <can.guo@oss.qualcomm.com>
In-Reply-To: <e79510e02e1025f9a5c3dff0208cf63b22054bdb.camel@iokpp.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEwMiBTYWx0ZWRfX4FbUJNOPXtHI
 y86rWlA++4nuv1IiiVmopDFVpHte7YA6IXDMc0imHnpI91e6kh1ZpHspwvqxDwftFVo88ieEanh
 mko8Cs6b1Ze9VcZlLKlEmIuVXvujl9nZz8HkJrg6n2SjQGS+LOVn3EBnSQ6XKS01NQqq0j2USC6
 hWs9LRe44tq1B4OLNVI49t7khulz3GRr+0X/BXfpt7sSqBgSvDPrRRo6ox08xvC2eRN2IlC90sU
 2e67uA+zni1GSqsQ1Cvc29a8WIJdC/6kuEkAOlAYcButD+O7G2P1de6OqgbDAezMUCMiA9+hJRg
 I17n2Je+zTCG4VPfP/0LTMdXhC5pnyVSiIBaxEF+aM2eqOsk80GpoLkSmxJzIzrQDwjodaA2R1G
 b0DTCxTvtjP3XGg2RdM23GYMf4S4DOcWum0fHhabod79NzcwLHRwYVAP3LWtv3dQ387c4oZW5yM
 qpSrWNSXkHNU9cdQW1Q==
X-Proofpoint-GUID: jiuwzl4qPwDYc1DavVsiY_R9kpNOWsuk
X-Authority-Analysis: v=2.4 cv=WaM8rUhX c=1 sm=1 tr=0 ts=6a19689d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=PY6Zn8H8AAAA:8 a=ruldmeCcswPIRuO37jcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=ySS05r0LPNlNiX1MMvNp:22
X-Proofpoint-ORIG-GUID: jiuwzl4qPwDYc1DavVsiY_R9kpNOWsuk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290102
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-24223-lists,linux-scsi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,micron.com:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[can.guo@oss.qualcomm.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 21741600CC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/29/2026 6:19 PM, Bean Huo wrote:
> On Fri, 2026-05-29 at 16:42 +0800, Can Guo wrote:
>>> if (!lpd)
>>>        return;
>>>
>>> if (lpd > UFS_MAX_LANES) {
>>>        ...
>>> }
>> OK, got it.
>>
>> Thanks,
>> Can Guo.
> With this and Peter's num_elems rename addressed in v6, please add:
>
> Reviewed-by: Bean Huo <beanhuo@micron.com>
Thanks sir.

Can Guo.
>
> Thanks,
> Bean
>


