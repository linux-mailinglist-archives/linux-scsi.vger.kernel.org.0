Return-Path: <linux-scsi+bounces-24387-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tI3LCLdYH2pgkwAAu9opvQ
	(envelope-from <linux-scsi+bounces-24387-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 03 Jun 2026 00:27:03 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9602E632697
	for <lists+linux-scsi@lfdr.de>; Wed, 03 Jun 2026 00:27:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="Z/s9qazc";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=dONhf3Ti;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24387-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24387-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A58B630A8828
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Jun 2026 22:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6213BED58;
	Tue,  2 Jun 2026 22:24:42 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8125C3BADA3
	for <linux-scsi@vger.kernel.org>; Tue,  2 Jun 2026 22:24:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439081; cv=none; b=MwfGdfDTpDYbpFGxw+2KuIXDTjS2/rj/MMjvffdNf2p/EhiG3/XQwu4PFtYszTPwRf9CNrerr9hLKx9Z55+E7ooGbJ1+n2RHoAuLpHwWFdRAFoOV17Yhwrwffe8yGxTFpMTWpiklUEp+wjOghZRcIrmDpf00CRs4phCzPUcshgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439081; c=relaxed/simple;
	bh=V18lkZ+mYtRW45RZQcZ5zGi4H7dZflBvwdwCuHqEMXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b9fKnTJi6gux5Uk4kCn5gWHyYtX9jSDWCcFNO9PBP4nHJoLSRRKh7B+swA53jrAKcakC8Ka8vwq1VxyWG3zRpjY1WtoPon+qnJ9uEMBE9sHNnyQocgnTmp4Zm6FmOrJFvUpNZg9n7icpRIYyPfGPI06tCNoW4AT68tXgVanS8D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z/s9qazc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dONhf3Ti; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652MFNLY3302781
	for <linux-scsi@vger.kernel.org>; Tue, 2 Jun 2026 22:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A2btTWcfqlMf79K2ygn2F3WwB6X9SQ/bHFDltKt8bfE=; b=Z/s9qazc75eVm00Z
	hp9V2BaPvIjogFVlijZPwpE07pppmDpAQN9Dwugtykoz52kPiikfn2CrvkO+HSXE
	ktgFLHHrfgEkCajNC/YjEDI+uhDnDnwYzreKAEksO1i1NnYO7Hnrx3OJqKsWMqcb
	nLTPS06E/DgjDPn38l5tIENZexL9/o8Iiz/jkw68Mt/aEtvM1bLIVwNWeeQN5cPc
	x4fkIVBjVBwOKndXyjhsM8yKyT5zhGL4wMXBYSVi4VLelohgF0hfViRvvZSEXSKN
	ocFlENQhRtPqI3mpThO/S0quN2yrAQiqXhibU/njTd5nKvyyyp2eL4aJsRFuOhvb
	Kd6frQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehu18khqc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-scsi@vger.kernel.org>; Tue, 02 Jun 2026 22:24:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bf335549b8so55138825ad.1
        for <linux-scsi@vger.kernel.org>; Tue, 02 Jun 2026 15:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780439078; x=1781043878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2btTWcfqlMf79K2ygn2F3WwB6X9SQ/bHFDltKt8bfE=;
        b=dONhf3TiY3CBkyDTjpZnSnAmgBpRBgV366J8nYMP+w+dlnDKkUA/eoWdPRF7JwPv2D
         s0uo9m22QoElSdgJEEUUgRqVDVVjJOyYm/yKJD+lY3pA7v8iqO8xa1KvHon00EzmPl9g
         IAv60tjqgfaiJHUTGBmqMTytun3Jyh2aPsw2crTgkhNMS5jFB3AH61PFXNiYc4v5FCu8
         6DorED/Uy/qajoNWEkvX6G7Jwf7BYy3+1qw161/ugk19LKAZttbjH8JV2/IRUu8trBXy
         Y3Hyq/lj10caF25H2UCcaS/lslk01jkXWzOHm6VitBTiRh76STBOX4MX7ZRga/QLeXWr
         d8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780439078; x=1781043878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A2btTWcfqlMf79K2ygn2F3WwB6X9SQ/bHFDltKt8bfE=;
        b=QoiW28EubxchTpN5/6nd87RNgmj349WTpExp3tMXrLfCW2OEBVuAs5SY0m64wzvdXU
         Hya4aHRSvAnTUQ0V+3KJxVM30ffL3aqInsMr+p+XD7+td+ZUzDYQTHRbZSwlUjunykW9
         qEJW8Ig0VU5k58J+i8BE+KXrg6tjDijwnkZUv2ai3P3S6IDnvAhqhVkOkJ6WtYi4ZM2t
         L1kXmRk2MM2tQ83sSKBbT19hSGHcdornb0FE/zjNK7lIPlg6exrqJRM1F/MJtM6YJEV9
         Q4IxQVz3ZKHEhhTDQDDHDm5EXZAL/SWaGL8iA+5sPG4aJDAXpwK+NYo6Lfzw6acCy7Ju
         LKZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9/RYOua4Zylw6EtyXy/l2ENvjXwEA4YU1maNX2jkX8UotnRmXAKUISE2+wG3FAqZXnJW48R/l8qFH2@vger.kernel.org
X-Gm-Message-State: AOJu0YzN0fBwYufYVJOnfvSw85mkAggIPdgaYccnx/AG0RL+8g9luqDs
	v9qT0BdzxXPoEn37xFsUJSKGJ6Z1xJYx9rlN6XcRHOesz8+FwBd5PgTukKA2j/5jDjU3rMZ8oRf
	8yXdCF8KGXcX1/51P6r5o7JqZqfdvfBtZIp9kB0Op1KbFxSQXYRnMqYBLTVTGoA+r
X-Gm-Gg: Acq92OHfU4fJyhQHFVOKtqBkAOvf/CTrmLW5zGa4Kd2rmYeu0pwrrsl+z+7VF+0lVRG
	V4BsdpvGda4pmtniZoaFNxxMIKrrnJOLRamjEZsxLEdLWuIa4m8zd7lrrvoQarjOupoYHkn0WWu
	LPLGHQbveT65tRpg/w3E6xpQV/gl89e8i84cfEKfC0a/Svkig2rZeKlN1HjtZAnnPnRSoWZy4MF
	PXVTxFYOWKbBdCfHT/RCnarRXIAKsQ7fBeWEknhMzFWXZgqnA61bcUv0R+1RiyMQtzWVAMq+aTd
	NfcqeVSu7h4DRwuhOysq7ddne7vrgOGfNAcgzvDFOPaDIFKxztOM05pumo72JO1oEKLE/1dIC4V
	t0jfUNdXa88iNThd4w4sgtY0Bh66kyV1CwJmVL1bMgnTX9Fl2iU5GpQ0HusdJGzU80PZ4lg==
X-Received: by 2002:a17:903:1252:b0:2bf:2114:ecbe with SMTP id d9443c01a7336-2c163fa8545mr6071675ad.23.1780439078431;
        Tue, 02 Jun 2026 15:24:38 -0700 (PDT)
X-Received: by 2002:a17:903:1252:b0:2bf:2114:ecbe with SMTP id d9443c01a7336-2c163fa8545mr6071455ad.23.1780439077952;
        Tue, 02 Jun 2026 15:24:37 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e0ecsm2698035ad.45.2026.06.02.15.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:24:37 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 03:53:54 +0530
Subject: [PATCH v10 2/5] ufs: host: Add ICE clock scaling during UFS clock
 changes
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-enable-ice-clock-scaling-v10-2-b0b728435356@oss.qualcomm.com>
References: <20260603-enable-ice-clock-scaling-v10-0-b0b728435356@oss.qualcomm.com>
In-Reply-To: <20260603-enable-ice-clock-scaling-v10-0-b0b728435356@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=POA/P/qC c=1 sm=1 tr=0 ts=6a1f5827 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4vEl8bdWBwuQafGpEzkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDIxNyBTYWx0ZWRfXyE20Jc9oUh+U
 GeSL/41jX1r3TyovhH8DMWwf153nzgThnToGIxAUctghqGBnRs+AAMnKZ1XPzJwWgRYmS54GVc+
 jZCzww6/1WaFLLHb/rdZlg7xvaWBdV19IRGGEOQJAi/RaZOV74vKAglHx/vR+7rIE9UnEK9efy2
 LYyHo9o6ldplrk74mNiPgsonU7YkO6FVtbT1ngCLxaosKxOfRLGOHsC2x8kmzvFxzs9sQuAA9Ir
 89bA8RScDlFLoEmv1buSM4p94AjScrhjTyxg5y48oL2gpPMue0T8v03F9AZTVXuuO7OPf6hQGAL
 PkXzCSY0PmWbFpv8UmhiW31P367pjrLyWOccH1Sn8luW4PrzD2PAiG5Q5vxrodptXDDQkJS/lx9
 QMtd4EL/xyaAsge49JDmjYrTOJ6jnxm0p4Ij/hneLQ+jwlsLscsHG0xj5fq+KMze0nyOPdObR9S
 qot5CC1M/lON8h/jC3g==
X-Proofpoint-GUID: RfKsOAbk30g3j7gKcFdZ-e7P82YJItSk
X-Proofpoint-ORIG-GUID: RfKsOAbk30g3j7gKcFdZ-e7P82YJItSk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020217
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24387-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER(0.00)[abhinaba.rakshit@oss.qualcomm.com,linux-scsi@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:andersson@kernel.org,m:konradybcio@kernel.org,m:mani@kernel.org,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:adrian.hunter@intel.com,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:neeraj.soni@oss.qualcomm.com,m:harshal.dev@oss.qualcomm.com,m:kuldeep.singh@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:abhinaba.rakshit@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhinaba.rakshit@oss.qualcomm.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9602E632697

Implement ICE (Inline Crypto Engine) clock scaling in sync with
UFS controller clock scaling. This ensures that the ICE operates at
an appropriate frequency when the UFS clocks are scaled up or down,
improving performance and maintaining stability for crypto operations.

For scale_up operation ensure to pass ~round_ceil (round_floor)
and vice-versa for scale_down operations.

In case of OPP scaling is not supported by ICE, ensure to not prevent
devfreq for UFS, as ICE OPP-table is optional.

Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 drivers/ufs/host/ufs-qcom.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 291c4344876481461ab958f3048db5405bbead62..dc15d7806c7b677d6890cd4b077cae4f4d5c9a41 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -306,6 +306,15 @@ static int ufs_qcom_ice_prepare_key(struct blk_crypto_profile *profile,
 	return qcom_ice_prepare_key(host->ice, lt_key, lt_key_size, eph_key);
 }
 
+static int ufs_qcom_ice_scale_clk(struct ufs_qcom_host *host, unsigned long target_freq,
+				  bool round_ceil)
+{
+	if (host->hba->caps & UFSHCD_CAP_CRYPTO)
+		return qcom_ice_scale_clk(host->ice, target_freq, round_ceil);
+
+	return 0;
+}
+
 static const struct blk_crypto_ll_ops ufs_qcom_crypto_ops = {
 	.keyslot_program	= ufs_qcom_ice_keyslot_program,
 	.keyslot_evict		= ufs_qcom_ice_keyslot_evict,
@@ -340,6 +349,12 @@ static void ufs_qcom_config_ice_allocator(struct ufs_qcom_host *host)
 {
 }
 
+static int ufs_qcom_ice_scale_clk(struct ufs_qcom_host *host, unsigned long target_freq,
+				  bool round_ceil)
+{
+	return 0;
+}
+
 #endif
 
 static void ufs_qcom_disable_lane_clks(struct ufs_qcom_host *host)
@@ -1946,6 +1961,12 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba, bool scale_up,
 			return err;
 		}
 
+		err = ufs_qcom_ice_scale_clk(host, target_freq, !scale_up);
+		if (err && err != -EOPNOTSUPP) {
+			ufshcd_uic_hibern8_exit(hba);
+			return err;
+		}
+
 		ufs_qcom_icc_update_bw(host);
 		ufshcd_uic_hibern8_exit(hba);
 	}

-- 
2.34.1


