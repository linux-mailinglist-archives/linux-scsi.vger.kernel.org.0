Return-Path: <linux-scsi+bounces-15815-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9347CB1BA06
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Aug 2025 20:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B1018A60CB
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Aug 2025 18:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A61298999;
	Tue,  5 Aug 2025 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a93Oo/fb"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9281E277819
	for <linux-scsi@vger.kernel.org>; Tue,  5 Aug 2025 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754418425; cv=none; b=hfzDeNK424PUwB67gyZgzOEm0CdWae/hJDQs4KMXliLBGYNvokdRKB0T3NrH/DeTJeXSGTaq2rxxFXjCsS1zcvq6CfY9tsFQ/IahnTt9BPS9oNrdatF9h45UEXKD8BTz9yncNnJoKKAM5XjIv3/WpoWVPZveCyHjDiNCFm4rNnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754418425; c=relaxed/simple;
	bh=6y8nlc9gd+kcsuPS309XlKj1GjKIPI4qnHhdViPlT3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkwHunzrSr+N18fPKFARLe1cWwByAYKZ7T3Pa59WVACa9mYPC3ptdx06pY6htG+/S4lbe2+wxiVLd/BVFglEhUzcjlPDFF2GkU7TyO+mCEYK+eYjLYkwEagtlu/SzukLvN6GG29Kbe/Fye3LEaapMf3h8lNAb0Is8QqanxWDazE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a93Oo/fb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575I2WVA019400
	for <linux-scsi@vger.kernel.org>; Tue, 5 Aug 2025 18:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8X+rFEyh78q3PUoe5+Y4jMYH5oFL6y+MBtI/T1H47EQ=; b=a93Oo/fb/ngIEVQ9
	j0Ro2fFoX2FjfFDx8J6daWRewfH7wfgLBqQCkv8pvlwyXlhQmnc1ZLsvGClMeQbq
	lOUgwBfjE1cu1QyAWV4nLp1D5sSdvhhmaNdUgk+rCim+3UuABe90F/7XpdoEco+o
	KemsCIKonzMWpixuqLxPJ7Xl/JjF5hr2x4aWFhn5q03GnhBi9x6CTSarjS+k7fLP
	0OXTV0UgY07aXBB3R0zCxlWEZ36BY6RmnoPB7nIYE+XgwHAwQCZnpZzUp8Fukn2o
	8VriSv/HoQknP9QBDjspEpyAzVeTlkcchmArVZFrg1y02+a8SnZA0O2QjmIppw5h
	3D8/Ig==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpvvr2b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-scsi@vger.kernel.org>; Tue, 05 Aug 2025 18:27:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4af23fa7c0cso10615901cf.2
        for <linux-scsi@vger.kernel.org>; Tue, 05 Aug 2025 11:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754418421; x=1755023221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8X+rFEyh78q3PUoe5+Y4jMYH5oFL6y+MBtI/T1H47EQ=;
        b=vHCAqVPB1ipMe3S4dASxxOePu7disxKgwuqNHbGIzg39rSYNXb1ZMGk+YHccXmPD/Z
         8c8nHcxtqBKRLEo5rHmWPkOOcI+3lkT3JKl/B3o9aqfU7RU8p7gk8jLHm4vcR4U9aYea
         NZOf8pcAoWjmnlTatS1tTSWfPATByd4YKCOH/oDUHpgMcvtVkf9kJ/Ymoxy68+vQcVe6
         GOBsVWGpnnkAbSppAQX45LuZck4+0E/vQviwdsAfeF3WDAtmBkULNzRV4UzwXHh5wWle
         yB2R8zIPvKCWrGDn7EbMcuy5ojstzFh9VFFqQ/BVT6A6dv6u1IxyWyDI+rTFdeJBzTbM
         RWfg==
X-Forwarded-Encrypted: i=1; AJvYcCUUXE52FqELIgHVi112nvisB0qYHRyJl7U0Mp/cKY8IS0BjVRCD2ccvWZDbtg8dTQYA7F3RN/NTvg9S@vger.kernel.org
X-Gm-Message-State: AOJu0YzhNEtMed6nmev9iTo55tWvBGb+9tT2ET00v25a6m15g9C8xhwx
	gk9nL5mOjb4gQvX2gVScX8yUR4d2oBer9A1WJuA3vTIXNokV7GpFyuMxCHQWbFjPyMjSBopkgsS
	MV2+7oeKIQ9LbStDdeByDtGBY9Hmq143Ur9L/W2VFT215dRwftsFVUQCJUW9jcT2Z
X-Gm-Gg: ASbGncvlMc4FENG3QQCb/HfDmgj/i0BJg4FRb5sVTFV/ffdKwG4W5Ev5N75Hsi6cH4+
	Lk/BMHC8qBGXHIcbEaGhk6GcwPu1PkJXLMHmattn+HTuep2hdwhiW1M2jUteaROvbhJPtL7Vn29
	a5u2poYq1GyRFlYhec/kyvJMIBSe3his99ZiCkWtgh38WjfXUKFm/kRxYbBlzxn9yP0GPYn+ag6
	jDJIr2PkR/qHlBuW9KHfZZprV0Uzgp/eiKqR0ywGzqZfjE00laO6YX2Ri05whht0PzfcT7WsjO9
	Kdy/SOF/cjJoSEFPk4otQvod7dxZPbqPxHkAmBITpLKQy/Q+8BceZSFZZWf5h4SezeD9FdhFIFl
	4erBaZ0wUfiUBqsc/Lw==
X-Received: by 2002:a05:622a:8358:b0:4b0:7e9f:aff8 with SMTP id d75a77b69052e-4b07e9fbdfbmr31517341cf.11.1754418421152;
        Tue, 05 Aug 2025 11:27:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZlCU8CvK41aG98FrS4OVUGBpHFuya4XLRz4mNMlXfYenvsD4229VwAFQ/ihh8G6Z8SHozlA==
X-Received: by 2002:a05:622a:8358:b0:4b0:7e9f:aff8 with SMTP id d75a77b69052e-4b07e9fbdfbmr31517091cf.11.1754418420464;
        Tue, 05 Aug 2025 11:27:00 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a37a8sm957277266b.40.2025.08.05.11.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 11:26:59 -0700 (PDT)
Message-ID: <3cd33dce-f6b9-4f60-8cb2-a3bf2942a1e5@oss.qualcomm.com>
Date: Tue, 5 Aug 2025 20:26:57 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sa8155: Add gear and rate limit
 properties to UFS
To: Alim Akhtar <alim.akhtar@samsung.com>,
        'Manivannan Sadhasivam' <mani@kernel.org>
Cc: 'Krzysztof Kozlowski' <krzk@kernel.org>,
        'Ram Kumar Dwivedi' <quic_rdwivedi@quicinc.com>, avri.altman@wdc.com,
        bvanassche@acm.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <2a3c8867-7745-4f0a-8618-0f0f1bea1d14@kernel.org>
 <jpawj3pob2qqa47qgxcuyabiva3ync7zxnybrazqnfx3vbbevs@sgbegaucevzx>
 <fa1847e3-7dab-45d0-8c1c-0aca1e365a2a@quicinc.com>
 <1701ec08-21bc-45b8-90bc-1cd64401abd8@kernel.org>
 <2nm7xurqgzrnffustrsmswy2rbug6geadaho42qlb7tr2jirlr@uw5gaery445y>
 <11ea828a-6d35-4ac6-a207-0284870c28fc@oss.qualcomm.com>
 <jogwisri2gs77j5cs3xwyezmfsotnizvlruzzelemdj5xadqh4@loe7fsatoass>
 <CGME20250805170638epcas5p4cb0cc78c5b5d77072cec547380b9f03d@epcas5p4.samsung.com>
 <b235e338-8c16-439b-b7a5-24856893fb5d@oss.qualcomm.com>
 <061b01dc062d$25c47800$714d6800$@samsung.com>
 <i6eyiscdf2554znc4aaglhi22opfgyicif3y7kzjafwsrtdrtm@jjpzak64gdft>
 <061c01dc062f$70ec34b0$52c49e10$@samsung.com>
 <87c37d65-5ab1-4443-a428-dc3592062cdc@oss.qualcomm.com>
 <061d01dc0631$c1766c00$44634400$@samsung.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <061d01dc0631$c1766c00$44634400$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 72LpEzQ567AQ9tURZjhw7p0cxOl0KwG4
X-Authority-Analysis: v=2.4 cv=GttC+l1C c=1 sm=1 tr=0 ts=68924cf6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=hD80L64hAAAA:8
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=JF9118EUAAAA:8 a=N54-gffFAAAA:8
 a=bLk-5xynAAAA:8 a=yPCof4ZbAAAA:8 a=vENURVL_7Fm7xlK8qQ8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
 a=xVlTc564ipvMDusKsbsT:22 a=zSyb8xVVt2t83sZkrLMb:22
X-Proofpoint-GUID: 72LpEzQ567AQ9tURZjhw7p0cxOl0KwG4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEyOSBTYWx0ZWRfXxuNAXg6TjHxn
 UZj3XjTRE0mFXIpe+Ok/XVZoFf2JSPh3pFzH1TYHAj/TTbap9bSKJWSOGf9jzpxuvvG3691wdsn
 VzR77it1aLeDAJk7nbiWiH+a3Jv+yFU7ACrWdhuKIIpeL7sr5U2RTHIVVVNoxQp5GMZXTSR5Rpz
 FbAiSBLeNKcuf1yT9frGvEvpztwjIKZT0i10GlCg1MHBxGk+z22hs9vTlSZ6nrdN37R01MHmiVw
 Du9TjrIN8GKkOjec8NUxjJMxNPgxO72/c1IciTDOUpo5xl73VQsVheJ835hYNyGpjErpEXOJIeZ
 yMbQBx7hK23RpR2WIxRsbJYuAnn2crVxyPOqdRUADm333e5CYMGu/nj57TT/gk1qPPO/hIFmlhl
 Bo/W0h+kw0ReHifOFaDNT8s1vLO6riBzQo8nfA8bYQ+FWF1HKxzl54ksUvvF8D4wYDhmTRBX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 phishscore=0
 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508050129

On 8/5/25 7:52 PM, Alim Akhtar wrote:
> 
> 
>> -----Original Message-----
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Sent: Tuesday, August 5, 2025 11:10 PM
>> To: Alim Akhtar <alim.akhtar@samsung.com>; 'Manivannan Sadhasivam'
>> <mani@kernel.org>
>> Cc: 'Krzysztof Kozlowski' <krzk@kernel.org>; 'Ram Kumar Dwivedi'
>> <quic_rdwivedi@quicinc.com>; avri.altman@wdc.com;
>> bvanassche@acm.org; robh@kernel.org; krzk+dt@kernel.org;
>> conor+dt@kernel.org; andersson@kernel.org; konradybcio@kernel.org;
>> James.Bottomley@hansenpartnership.com; martin.petersen@oracle.com;
>> agross@kernel.org; linux-arm-msm@vger.kernel.org; linux-
>> scsi@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH 2/3] arm64: dts: qcom: sa8155: Add gear and rate limit
>> properties to UFS
>>
>> On 8/5/25 7:36 PM, Alim Akhtar wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: 'Manivannan Sadhasivam' <mani@kernel.org>
>>>> Sent: Tuesday, August 5, 2025 10:52 PM
>>>> To: Alim Akhtar <alim.akhtar@samsung.com>
>>>> Cc: 'Konrad Dybcio' <konrad.dybcio@oss.qualcomm.com>; 'Krzysztof
>>>> Kozlowski' <krzk@kernel.org>; 'Ram Kumar Dwivedi'
>>>> <quic_rdwivedi@quicinc.com>; avri.altman@wdc.com;
>> bvanassche@acm.org;
>>>> robh@kernel.org; krzk+dt@kernel.org;
>>>> conor+dt@kernel.org; andersson@kernel.org; konradybcio@kernel.org;
>>>> James.Bottomley@hansenpartnership.com;
>> martin.petersen@oracle.com;
>>>> agross@kernel.org; linux-arm-msm@vger.kernel.org; linux-
>>>> scsi@vger.kernel.org; devicetree@vger.kernel.org; linux-
>>>> kernel@vger.kernel.org
>>>> Subject: Re: [PATCH 2/3] arm64: dts: qcom: sa8155: Add gear and rate
>>>> limit properties to UFS
>>>>
>>>> On Tue, Aug 05, 2025 at 10:49:45PM GMT, Alim Akhtar wrote:
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>> Sent: Tuesday, August 5, 2025 10:36 PM
>>>>>> To: Manivannan Sadhasivam <mani@kernel.org>
>>>>>> Cc: Krzysztof Kozlowski <krzk@kernel.org>; Ram Kumar Dwivedi
>>>>>> <quic_rdwivedi@quicinc.com>; alim.akhtar@samsung.com;
>>>>>> avri.altman@wdc.com; bvanassche@acm.org; robh@kernel.org;
>>>>>> krzk+dt@kernel.org; conor+dt@kernel.org; andersson@kernel.org;
>>>>>> konradybcio@kernel.org; James.Bottomley@hansenpartnership.com;
>>>>>> martin.petersen@oracle.com; agross@kernel.org; linux-arm-
>>>>>> msm@vger.kernel.org; linux-scsi@vger.kernel.org;
>>>>>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
>>>>>> Subject: Re: [PATCH 2/3] arm64: dts: qcom: sa8155: Add gear and
>>>>>> rate limit properties to UFS
>>>>>>
>>>>>> On 8/5/25 6:55 PM, Manivannan Sadhasivam wrote:
>>>>>>> On Tue, Aug 05, 2025 at 03:16:33PM GMT, Konrad Dybcio wrote:
>>>>>>>> On 8/1/25 2:19 PM, Manivannan Sadhasivam wrote:
>>>>>>>>> On Fri, Aug 01, 2025 at 11:12:42AM GMT, Krzysztof Kozlowski
>> wrote:
>>>>>>>>>> On 01/08/2025 11:10, Ram Kumar Dwivedi wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 01-Aug-25 1:58 PM, Manivannan Sadhasivam wrote:
>>>>>>>>>>>> On Thu, Jul 24, 2025 at 09:48:53AM GMT, Krzysztof Kozlowski
>>>> wrote:
>>>>>>>>>>>>> On 22/07/2025 18:11, Ram Kumar Dwivedi wrote:
>>>>>>>>>>>>>> Add optional limit-hs-gear and limit-rate properties to the
>>>>>>>>>>>>>> UFS node to support automotive use cases that require
>>>>>>>>>>>>>> limiting the maximum Tx/Rx HS gear and rate due to
>> hardware
>>>> constraints.
>>>>>>>>>>>>>
>>>>>>>>>>>>> What hardware constraints? This needs to be clearly
>>>> documented.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Ram, both Krzysztof and I asked this question, but you never
>>>>>>>>>>>> bothered to reply, but keep on responding to other comments.
>>>>>>>>>>>> This won't help you to get this series merged in any form.
>>>>>>>>>>>>
>>>>>>>>>>>> Please address *all* review comments before posting next
>>>> iteration.
>>>>>>>>>>>
>>>>>>>>>>> Hi Mani,
>>>>>>>>>>>
>>>>>>>>>>> Apologies for the delay in responding.
>>>>>>>>>>> I had planned to explain the hardware constraints in the next
>>>>>> patchset’s commit message, which is why I didn’t reply earlier.
>>>>>>>>>>>
>>>>>>>>>>> To clarify: the limitations are due to customer board designs,
>>>>>>>>>>> not our
>>>>>> SoC. Some boards can't support higher gear operation, hence the
>>>>>> need for optional limit-hs-gear and limit-rate properties.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> That's vague and does not justify the property. You need to
>>>>>>>>>> document instead hardware capabilities or characteristic. Or
>>>>>>>>>> explain why they cannot. With such form I will object to your
>>>>>>>>>> next
>>>>>> patch.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I had an offline chat with Ram and got clarified on what these
>>>>>>>>> properties
>>>>>> are.
>>>>>>>>> The problem here is not with the SoC, but with the board design.
>>>>>>>>> On some Qcom customer designs, both the UFS controller in the
>>>>>>>>> SoC and the UFS device are capable of operating at higher gears
>>>>>>>>> (say
>>>> G5).
>>>>>>>>> But due to board constraints like poor thermal dissipation,
>>>>>>>>> routing loss, the board cannot efficiently operate at the higher
>>>> speeds.
>>>>>>>>>
>>>>>>>>> So the customers wanted a way to limit the gear speed (say G3)
>>>>>>>>> and rate (say Mode-A) on the specific board DTS.
>>>>>>>>
>>>>>>>> I'm not necessarily saying no, but have you explored sysfs for this?
>>>>>>>>
>>>>>>>> I suppose it may be too late (if the driver would e.g. init the
>>>>>>>> UFS at max gear/rate at probe time, it could cause havoc as it
>>>>>>>> tries to load the userland)..
>>>>>>>>
>>>>>>>
>>>>>>> If the driver tries to run with unsupported max gear speed/mode,
>>>>>>> it will just crash with the error spit.
>>>>>>
>>>>>> OK
>>>>>>
>>>>>> just a couple related nits that I won't bother splitting into
>>>>>> separate emails
>>>>>>
>>>>>> rate (mode? I'm seeing both names) should probably have dt-bindings
>>>>>> defines while gear doesn't have to since they're called G<number>
>>>>>> anyway, with the bindings description strongly discouraging use,
>>>>>> unless absolutely necessary (e.g. in the situation we have right
>>>>>> there)
>>>>>>
>>>>>> I'd also assume the code should be moved into the ufs-common code,
>>>>>> rather than making it ufs-qcom specific
>>>>>>
>>>>>> Konrad
>>>>> Since this is a board specific constrains and not a SoC properties,
>>>>> have an
>>>> option of handling this via bootloader is explored?
>>>>
>>>> Both board and SoC specific properties *should* be described in
>>>> devicetree if they are purely describing the hardware.
>>>>
>>> Agreed, what I understood from above conversation is that, we are try
>>> to solve a very *specific* board problem here, this does not looks like a
>> generic problem to me and probably should be handled within the specific
>> driver.
>>
>> Introducing generic solutions preemptively for problems that are simple in
>> concept and can occur widely is good practice (although it's sometimes hard
>> to gauge whether this is a one-off), as if the issue spreads a generic solution
>> will appear at some point, but we'll have to keep supporting the odd ones as
>> well
>>
> Ok, 
> I would prefer if we add a property which sounds like "poor thermal dissipation" or 
> "routing channel loss" rather than adding limiting UFS gear properties. 
> Poor thermal design or channel losses are generic enough and can happen on any board.

This is exactly what I'm trying to avoid through my suggestion - one
board may have poor thermal dissipation, another may have channel
losses, yet another one may feature a special batch of UFS chips that
will set the world on fire if instructed to attempt link training at
gear 7 - they all are causes, as opposed to describing what needs to
happen (i.e. what the hardware must be treated as - gear N incapable
despite what can be discovered at runtime), with perhaps a comment on
the side

Konrad

