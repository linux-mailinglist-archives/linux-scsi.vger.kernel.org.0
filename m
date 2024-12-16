Return-Path: <linux-scsi+bounces-10898-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C2C9F30A9
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Dec 2024 13:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F03F165F37
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Dec 2024 12:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2E5204C3F;
	Mon, 16 Dec 2024 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Onqa4AYK"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ABF204C01
	for <linux-scsi@vger.kernel.org>; Mon, 16 Dec 2024 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734352691; cv=none; b=gG2txd3VK63ZgS5PS2LVgm+bqVVo/DtGHzxnzE1rruxvsNd/P7deg8AY0aUB5X5nIpo9e/LJtp9eeaMZH58I5f/ckJWryEMRksNOK2HhDSmu0j65uk0CFvLkSiISsBU2z0v1E/yIHY03LcUPHTUYKd+9zJVTdMsD58KhTmVvH4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734352691; c=relaxed/simple;
	bh=b75U/HA0CloJ0+/UzTC6aq4XLDPDoiTRS7cOJTC8ZYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6KY0Nf7QxCCon/itrtJ6qgRcCnZeb5JsrOpc2tTqn4cdBAA88Ow7nSlwn5VTWiQCfUDtDVyrFiy2GyQVhJxNThWNR22/SDsSEazlRpgat9fLpSZ15G0NGLHccGbx+AjrO9Gw3Zo7Mb3+0jkhpeL/0UIaJ1/ogP0TbOlssNCo/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Onqa4AYK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGBLD5N026407
	for <linux-scsi@vger.kernel.org>; Mon, 16 Dec 2024 12:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pdnRoC01OFV41wLMXSS0ru37AeoKmw/OKRkPEM9jyW4=; b=Onqa4AYK2QDV++uT
	4AozVd46bZAyIYtEspwQst6eg4hJGOir5KYvf0fLpeSgZlsV1LlzEAJIDPTlyGsq
	8anMWI6Z0NPZPRTmcBwQjjoVqFO+88RwpbjOSojQ/oh9k/VTD8LREx6mSW7Akpy0
	j7KosvP0X/gl/7jYnxK9gqfuaojGUnoKbSonMmZVu4DlGqef9odV0H8cybxPbuEz
	7LEGXlJSPFfTEYl3WXVTj3daxgr/oWqXMFMOurQKpjbJSdMMg3tD613dT2tZSYjQ
	pCRiS9/L05b/piOivmeY1cvcqPzYC8hQWwR0rg1IZSygVvfwh4VUmsTf+yMq4nGl
	5kswKQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jk8gr7r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-scsi@vger.kernel.org>; Mon, 16 Dec 2024 12:38:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-467bb3eea80so893941cf.2
        for <linux-scsi@vger.kernel.org>; Mon, 16 Dec 2024 04:38:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734352688; x=1734957488;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdnRoC01OFV41wLMXSS0ru37AeoKmw/OKRkPEM9jyW4=;
        b=LMTUEJhnXIc7vO9jcLveuNWIvUDZ+GrUH6rfDXs3R4bWaXZGSoR2Me4O7+fakCH9HL
         Q+zwdZQCdEtGke3kDDYHDKjsZucMLVzkbPdODL7JQJz+1YwJS9iWEpxDzNEwGi6VDGJ+
         ZrRhdD1nkbuyLd3WsKzVYTHVnZH06+cdbSopSwcDZ2rEEUNfLie/KG5mjTC4G1NiXA43
         qWMku73GWOFdtHvkgzAiNzHtArwegiFaubWjzqcfHxScwkq1MrbY7gBLqaLvDZY8kAIL
         +AjYEc5UfYqLVZv8CfwG+1Vid0leJ9IsMm7MBuIr+m9P7czHQqL2W5R9f64sHvSHoPAV
         oyEA==
X-Forwarded-Encrypted: i=1; AJvYcCW0QTFS8SmJ94q1k8ZvhRaHDcfLuFK5ps4iZvYvcQzeVprZR3f7J0hhXuXlMArToD0EUna0yefnscch@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6owKHGKjR0VtFKQ6hzm6RwPuZx0suIGz3lne2Rg1wXTQ2OALc
	5ur8a6qiA+Iw3y+4jovufU5E+MR8RnES+Q6NXXfjwnMqXQIC1N2M4n3C8+DM5cQQusyju9TZ0qf
	Qvz7Zp1PjJv7froaNFGruWLsl4YzCzTJnjVt8GoBaab19bVqGp2cgb2fEPbcw
X-Gm-Gg: ASbGncvkdZK2k1ale5lNOtZDo/nMG0ZuTL36QEqlVzyBmQgpvyTLgchqQPEEBZWwMwV
	KSTRKYtQKaSz7unrN7z2HgI+HWsufC+NzPR69hFKxQwQyTjtP9PjFXH/opQXpT39SsatP5NdWPa
	PC0yKEbAEZSVvP97idWkxB6ks0BZ6825Nee2mpKXsVkqR6RtdFSE2voU8FoI41BW+wBDD6OwZ6K
	IwEktE27zAGWttfPhOiVYxOHvBgi1v8Rkk7Azq3w1qkS+ddEc6UpKznj0k0hMfIEyxblBsCepsQ
	pIhpG5/qWdKBkfN3CXHjYNCllEdeXupdRt8=
X-Received: by 2002:ac8:5790:0:b0:467:5931:f6a8 with SMTP id d75a77b69052e-467a586e7c4mr68200151cf.16.1734352688094;
        Mon, 16 Dec 2024 04:38:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBZq+xdirGGlvXjXKLslR6dJXMeyFlRPNL9zK3PD5HijaosBXr9Pya5+Lx8++owoZlIykajA==
X-Received: by 2002:ac8:5790:0:b0:467:5931:f6a8 with SMTP id d75a77b69052e-467a586e7c4mr68200011cf.16.1734352687718;
        Mon, 16 Dec 2024 04:38:07 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ec48sm327517966b.147.2024.12.16.04.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 04:38:07 -0800 (PST)
Message-ID: <14b1d2f7-0c0e-4976-b4c6-fe3b76b55d9f@oss.qualcomm.com>
Date: Mon, 16 Dec 2024 13:38:05 +0100
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] arm64: dts: qcom: qcs615: add UFS node
To: Xin Liu <quic_liuxin@quicinc.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, quic_jiegan@quicinc.com,
        quic_aiquny@quicinc.com, quic_tingweiz@quicinc.com,
        quic_sayalil@quicinc.com
References: <20241216095439.531357-1-quic_liuxin@quicinc.com>
 <20241216095439.531357-3-quic_liuxin@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241216095439.531357-3-quic_liuxin@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Cqy5FcaeeEDp04LMTqGY9-Jo8BlczLGO
X-Proofpoint-ORIG-GUID: Cqy5FcaeeEDp04LMTqGY9-Jo8BlczLGO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=756 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160107

On 16.12.2024 10:54 AM, Xin Liu wrote:
> From: Sayali Lokhande <quic_sayalil@quicinc.com>
> 
> Add the UFS Host Controller node and its PHY for QCS615 SoC.
> 
> Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Co-developed-by: Xin Liu <quic_liuxin@quicinc.com>
> Signed-off-by: Xin Liu <quic_liuxin@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

