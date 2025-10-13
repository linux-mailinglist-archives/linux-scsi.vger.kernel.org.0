Return-Path: <linux-scsi+bounces-18012-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEB2BD2FFE
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Oct 2025 14:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AA63B7494
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Oct 2025 12:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529ED270576;
	Mon, 13 Oct 2025 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TXcT0qSB"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE53424A06B
	for <linux-scsi@vger.kernel.org>; Mon, 13 Oct 2025 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358897; cv=none; b=RuFoWceMl98LhLHuQvs50/04r5v6wfSsbMqCKb5L8MpvG45pFLgXe0tuuIiv93mvH0QvQtNaOze0o36Dk7VyYbqZfbgPAsF8h2O0XrPgPKsvqH0x5NkHS3taS3UtYpsduW3FdknpjMrQJwgepr8JNZ417OyOozkeiVaL0ECoa80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358897; c=relaxed/simple;
	bh=ajB9cgC6bRzVciNEiJ5Rlu8UcrAcaygnA0NUSrk7i8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkuia8CqRTvb2Az1tcknAWEaJ6qsNTf86KFdUBeXRQDyF2vAlJ3J/y1T2gKAyVN6cFDDcMo6T/cGo9+hbPQAERrIKl8Zt1l0vT4PiNE5QJemRVH8v+Iji9DxmbQ3dNVYQi6DGcppHF1zQxdnP8MVQbfoqkHiAzzp2fvR+cYgRlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TXcT0qSB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DBAmML021336
	for <linux-scsi@vger.kernel.org>; Mon, 13 Oct 2025 12:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gObp1VGk4sT3wo0aNUTQnaxb
	hlPxOaJ9VK/6dcghZLQ=; b=TXcT0qSBuY5yfp/PNTnIrw7XNb+s9/QYCReqou30
	gtIGh5w1O98le1QLr/UGIlqf0FRAMWKyhoiDDhQq/h5jYDxRoxHhe6PFGxmTGO4+
	iKvu+DfCH4bBE45FfhsCs0Kr6YXrVVfvxA52xvansO5wQ7lI0sOFFKbBRHrR6CF0
	h8H2/uLaBv/6+Iq89Xp4/B79JK/GTDI0ThFUGtYMDBywKpLJu8svaMWw/lmLFzZu
	R+K8n4dJuanKaKDQH7sH9oCVV5sXmIT25qvxdKQhxYsCoq+ieJP5tDS+KCFNMaG+
	OCfDv0LxPObPXHhVyDS8uCiV5xNtoVyaJw4sHJ0TQhqPDw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgh64env-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-scsi@vger.kernel.org>; Mon, 13 Oct 2025 12:34:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8635d475556so1090915485a.0
        for <linux-scsi@vger.kernel.org>; Mon, 13 Oct 2025 05:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760358893; x=1760963693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gObp1VGk4sT3wo0aNUTQnaxbhlPxOaJ9VK/6dcghZLQ=;
        b=OD/1lWPtG3/ScuUnv/GNOtFGBsDUViweKIYtPXDLYSVOL+LrVVb0sT4nnr4hCCbXRB
         PLY6SZcIUwGYtNc4JdERQ6DW31QL0md8sLWVyQQyyGA8HxfpVE34C9VPoVNxokDaQ0Lr
         PYM5pOG8Exr9OVXJkCKT+mV19wy1WjjfVqxxam8PmsrA9SkHHr6oO+ybIE4IxJx86iMI
         baQQDA9E8YfIz67hx22xFFdq8hnJhDvYbgOnJjA8Q7WgUdXlFfsclbGPzfA8dOvbgAQh
         rcirtWv3ojfPXWp8FuABhDI+ObK0VnrZckOg9unLaJsGFKYcUFNtx1bTDeNLBdlWiWKN
         Vlfw==
X-Forwarded-Encrypted: i=1; AJvYcCXHWKAQCRDZkf2qkvhCfa9etq35EQTnLeZn1gXtCRQdEFVhN4SIO7xJjfav+DWx/h/paGd2t9vSlf1C@vger.kernel.org
X-Gm-Message-State: AOJu0YwM7letLZG8/yQNxiWN+ccpdDS0ayuuJlQLGjq5p8woobz6eZXf
	+N0mWvKh2p7FW4HH+AI8RrXaS5ZsFw/2dGTXpY6mIyyWOqxLCVPWa1kN9NVHdHupNZmjtM5tm88
	I1+x0N9IYriSU27ARfXX3L8G0uH/lGmHEcE/ia9YXRa0qaQ+BLCXHPMhaUM+Ek2P7oCbjL8At
X-Gm-Gg: ASbGncuubEyxAHeG5o2XG3mQum8yNLNtGqT+6aXpsHLtkW+B0kxA9CWpyNij5MtyNoe
	dU0h+YKH/8CNbuyFqCu1t9qjpuMU0/K7XQlaKAH49CCN12pdsQ0iJL71NiAGgXTO5+SQX1mr4Hs
	/L4kkLVK6HkWWksUf3M1OqjLMD0K47qTyXxqvKb/fLEUaYvbnaa+ZzGEHIx/oPNSJz5dTfpsDB7
	VsiURp9Iu5pScbP1G0rVog2KJiJi74Qlpis7TtFCpBEtBiIq9qBrZfoejO/bBOky10vulP3WUAQ
	I169xvYrC4PrTuXv5E1Pyg96CmD+h7QwmYS3usDrNlHEKiJu3y+22I+RgkExpAn20fOj9zP6Mse
	STMNVpN3gRiQNmwjR0Yq+PW0XIzjJ3J2Agp/qK7utveez2JeMdv7i
X-Received: by 2002:ac8:5885:0:b0:4b7:9581:a211 with SMTP id d75a77b69052e-4e6eace7e6cmr280427751cf.24.1760358893329;
        Mon, 13 Oct 2025 05:34:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5+lAIUbag3KQ/uyAYMUw2tzUdGLO9/5D5HdSvdyoQpY7sOU2YLiAsMhiWrQQX23CCsWeehA==
X-Received: by 2002:ac8:5885:0:b0:4b7:9581:a211 with SMTP id d75a77b69052e-4e6eace7e6cmr280427561cf.24.1760358892867;
        Mon, 13 Oct 2025 05:34:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088563b53sm4075703e87.84.2025.10.13.05.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 05:34:52 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:34:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ritesh Kumar <quic_riteshk@quicinc.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jessica.zhang@oss.qualcomm.com, sean@poorly.run,
        marijn.suijten@somainline.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mahap@quicinc.com, andersson@kernel.org,
        konradybcio@kernel.org, mani@kernel.org,
        James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        vkoul@kernel.org, kishon@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-phy@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        quic_vproddut@quicinc.com
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: qcom-edp: Add edp ref clk for
 sa8775p
Message-ID: <aifibm7pjva3rkb4gkzyxun46sraxyeh7jh6vgcirv5tsbf6ad@7f5bbs4ix7sa>
References: <20251013104806.6599-1-quic_riteshk@quicinc.com>
 <20251013104806.6599-2-quic_riteshk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013104806.6599-2-quic_riteshk@quicinc.com>
X-Authority-Analysis: v=2.4 cv=H/zWAuYi c=1 sm=1 tr=0 ts=68ecf1ef cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=yLsOkrEfH68IAt7CJG4A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNiBTYWx0ZWRfX1WxvN6YPtKjh
 sam2FwZZZsOLuwUvi6m8/yc3aKZaZUAsLwtn/NPU1ZzXu+S57grXNjGRFH5uZ2fDNK0599PPrB7
 +6pINDWBQcla1osTZ3I0r6UpCu/kE7DAAPMzVxHCy4fX/13wlJ+/YlIV7524SWOy9fwio5YxvWh
 zhy1EQgId9jGldQCd3iAMS2JZdkyZVwnILOm3K5BQ7gvF75NL2uljVIZyhRP3DIzt9LNWfqb9Sf
 KLTPYaZvEW4FejjZe1xHUl0/45PNRkaMQXwEpwb7WNoArsMVB1CBud1tLz7aVeXXTtFbECRWARs
 qqgKZ7XN0sPZ0sjYtJkvYExHp/Apg+lUyNBTXe/jzC1L16428aqqi9VpRypjC8EEzBQQNcsne3t
 3wRVPzGMY9BSyhFXsFSyh9B3G6rDZQ==
X-Proofpoint-ORIG-GUID: PhLcqp12YbtLbYhtlb5O5yIhc72IrMia
X-Proofpoint-GUID: PhLcqp12YbtLbYhtlb5O5yIhc72IrMia
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110026

On Mon, Oct 13, 2025 at 04:18:04PM +0530, Ritesh Kumar wrote:
> Add edp reference clock for sa8775p edp phy.
> 
> Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> index bfc4d75f50ff..b0e4015596de 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> @@ -73,6 +73,7 @@ allOf:
>          compatible:
>            enum:
>              - qcom,x1e80100-dp-phy
> +            - qcom,sa8775p-edp-phy

Usually such lists are sorted.

>      then:
>        properties:
>          clocks:
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

