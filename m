Return-Path: <linux-scsi+bounces-2744-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A667B869DC6
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Feb 2024 18:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D411F1C207BF
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Feb 2024 17:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66351482E2;
	Tue, 27 Feb 2024 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="j4q6i4x6"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A064F5E6
	for <linux-scsi@vger.kernel.org>; Tue, 27 Feb 2024 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055165; cv=none; b=Nj67u+T2jBuFDFMhwkNAwZKdN+EefLfvE++KyfL8RRBvAeyyfcwq+jCJmuykY5O2466MaC5BLVAr+y44iKB4JFYrjGO/MGqfMmb0yCvwb3th2n1iwGJ1/ZG3Picjhhs8xYH5pEHG9wjsUL2flLGSrUB7uUUB7y3a4lAaudeG9eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055165; c=relaxed/simple;
	bh=LUAzzGAsXhREPdoUcePylVIfxGkoQUSMyQDF7ZAa0P0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V31PRvZoKTMnOFwZhBDtlZPniqttXqttwZPrTYSEGa9S/7leC6Lk4TadWxjaZYPNb/J7HDYSddpL/7K7SZe/+zi7n4GO3N2iPzYOS5dVfW5Ifa8pxpCCP80U0j3XerDj1Q8DS7vXKssBAR1C+gy43XSsVvdpM/tLvk/FM9FpCPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=j4q6i4x6; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RFhNdx005875;
	Tue, 27 Feb 2024 09:32:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=tsA0Gv1M
	6HovAS0VobvbxZMcWVZO+EnSZcTWJb1qs30=; b=j4q6i4x64qTRuoImSwq5PkVf
	ETImcATUi1wt6ooS5TTwqeISeMq4/GsORnuKCkCc3Vw93m2b36d/QZTyp5UXNl9Q
	WPXhrJMcrvUi/DwRkhrgDXChWryw6ZLmW9DMmIx6aLwFw7Gmp1/RrB8/icQuM+aB
	zVyIyGQB4XaWppfLmu8UAMaWbEVBN5cfbucnaF6LkplGrGd6yAU812qvJMtWXBE1
	YavlODGc1uvKvWZSa8R2uCbaLRS43xUn2U2EP7UNg1TxHf1qeeRljbT+w4m+k1C3
	zLJwfRxy8K0Z19Fxa3gLCsZjLh+1sxRQK2yBG9E4pzZnCCOjJ4uxnkys1XyMEg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3whjm68h0q-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 09:32:40 -0800 (PST)
Received: from DC6WP-EXCH01.marvell.com (10.76.176.21) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1258.12; Tue, 27 Feb 2024 09:32:39 -0800
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH01.marvell.com (10.76.176.21) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 27 Feb 2024 11:41:37 -0500
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 27 Feb 2024 08:41:37 -0800
Received: from stgdev-a5u16.punelab.marvell.com (stgdev-a5u16.punelab.marvell.com [10.31.33.187])
	by maili.marvell.com (Postfix) with ESMTP id 01B913F7099;
	Tue, 27 Feb 2024 08:41:34 -0800 (PST)
From: Nilesh Javali <njavali@marvell.com>
To: <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <GR-QLogic-Storage-Upstream@marvell.com>,
        <agurumurthy@marvell.com>, <sdeodhar@marvell.com>, <emilne@redhat.com>,
        <jmeneghi@redhat.com>
Subject: [PATCH v2 00/11] qla2xxx misc. bug fixes
Date: Tue, 27 Feb 2024 22:11:16 +0530
Message-ID: <20240227164127.36465-1-njavali@marvell.com>
X-Mailer: git-send-email 2.23.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gCSyXt3tMprGBjNV2SbOWKMSWgTtvevb
X-Proofpoint-GUID: gCSyXt3tMprGBjNV2SbOWKMSWgTtvevb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_03,2024-02-27_01,2023-05-22_02

Martin,

Please apply the qla2xxx driver miscellaneous bug fixes
to the scsi tree at your earliest convenience.

v2:
- Fix warning reported by kernel test robot
- Added Reviewed-by tag

Thanks,
Nilesh

Bikash Hazarika (1):
  qla2xxx: Update manufacturer detail

Nilesh Javali (1):
  qla2xxx: Update version to 10.02.09.200-k

Quinn Tran (6):
  qla2xxx: Prevent command send on chip reset
  qla2xxx: Fix N2N stuck connection
  qla2xxx: Split FCE|EFT trace control
  qla2xxx: NVME|FCP prefer flag not being honored
  qla2xxx: Fix command flush on cable pull
  qla2xxx: Delay IO Abort on PCI error

Saurav Kashyap (3):
  qla2xxx: Fix double free of the ha->vp_map pointer.
  qla2xxx: Fix double free of fcport
  qla2xxx: change debug message during driver unload

 drivers/scsi/qla2xxx/qla_attr.c    |  14 +++-
 drivers/scsi/qla2xxx/qla_def.h     |   2 +-
 drivers/scsi/qla2xxx/qla_gbl.h     |   2 +-
 drivers/scsi/qla2xxx/qla_init.c    | 128 +++++++++++++++--------------
 drivers/scsi/qla2xxx/qla_iocb.c    |  68 +++++++++------
 drivers/scsi/qla2xxx/qla_mbx.c     |   2 +-
 drivers/scsi/qla2xxx/qla_os.c      |   3 +-
 drivers/scsi/qla2xxx/qla_target.c  |  10 +++
 drivers/scsi/qla2xxx/qla_version.h |   4 +-
 9 files changed, 138 insertions(+), 95 deletions(-)


base-commit: f4469f3858352ad1197434557150b1f7086762a0
-- 
2.23.1


