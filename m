Return-Path: <linux-scsi+bounces-11999-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A6AA28443
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Feb 2025 07:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907701629B4
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Feb 2025 06:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C90227BB7;
	Wed,  5 Feb 2025 06:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="SyVF8kAy"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-m32102.qiye.163.com (mail-m32102.qiye.163.com [220.197.32.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA709227B9C;
	Wed,  5 Feb 2025 06:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738736551; cv=none; b=RW11m8FoIsUo4Mq1SU02Y4s35ZA8MYzfIF+iSKdDXWqdT/aImlZ0e1eJMU6w2qp4UIdYJ+9Z4YC9IhzYVV5v1RRam2FrJFcBLWSSNsERG3IXuLs9nzmoARYtC7B3j742SGnCxGtNn23PeOGWO4qQJQLnHzTQi3JhT6v/bjqLCbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738736551; c=relaxed/simple;
	bh=xxuecMfLyM8ZbD30ki6zfARGYqQKNHYeoIL64hYa274=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uFJJ2p0KId3VvUNeTQWjhDK2MAB1JMrKHFsgdh4fjWMMsHjFIMI5tPmb9c2yoiv9Ek1gVb+PCJ4RGKi2gOoNdBgPvfeWAkp5qpSVSATeIjAC/gLxMnhNi7hsvzOI4icDIdkhI3sWCSzTx399NKrZVW53HkQhYdaj4VkG3zPJdEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=SyVF8kAy; arc=none smtp.client-ip=220.197.32.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id a34c466d;
	Wed, 5 Feb 2025 14:17:16 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Rob Herring <robh+dt@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	YiFeng Zhao <zyf@rock-chips.com>,
	Liang Chen <cl@rock-chips.com>,
	linux-scsi@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v7 2/7] soc: rockchip: add header for suspend mode SIP interface
Date: Wed,  5 Feb 2025 14:15:51 +0800
Message-Id: <1738736156-119203-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
References: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRodTVZISR0aHx9ITkJCHRpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a94d4c177e909cckunma34c466d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kxg6UTo*EDILFgssKDhOSjIf
	MkIaCglVSlVKTEhDTEhNSUhDSkpJVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpLSkw3Bg++
DKIM-Signature:a=rsa-sha256;
	b=SyVF8kAyAwBp37CZje4V4EArlFyA/9yRG+jNMmlB7KOC1luNXDRlfAedy35E4IFQwylYVEP/yC0/LU7e2UWDpocoSvhBTaIRDsl3tEB2S/xEipYGLQ80CEabqQiAfPYdD7rA71lMVykPG4ckAzyFIOsG/DMsLB2w0uhcGUllcQ0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=KIkDqSYySxC589k7eL7KHXXoH8abK9RP1DtbnQxT7jw=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>

Add ROCKCHIP_SIP_SUSPEND_MODE to pass down parameters to Trusted Firmware
in order to decide suspend mode. Currently only add ROCKCHIP_SLEEP_PD_CONFIG
which teaches firmware to power down controllers or not.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 include/soc/rockchip/rockchip_sip.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/soc/rockchip/rockchip_sip.h b/include/soc/rockchip/rockchip_sip.h
index c46a9ae..501ad1f 100644
--- a/include/soc/rockchip/rockchip_sip.h
+++ b/include/soc/rockchip/rockchip_sip.h
@@ -6,6 +6,9 @@
 #ifndef __SOC_ROCKCHIP_SIP_H
 #define __SOC_ROCKCHIP_SIP_H
 
+#define ROCKCHIP_SIP_SUSPEND_MODE		0x82000003
+#define ROCKCHIP_SLEEP_PD_CONFIG		0xff
+
 #define ROCKCHIP_SIP_DRAM_FREQ			0x82000008
 #define ROCKCHIP_SIP_CONFIG_DRAM_INIT		0x00
 #define ROCKCHIP_SIP_CONFIG_DRAM_SET_RATE	0x01
-- 
2.7.4


