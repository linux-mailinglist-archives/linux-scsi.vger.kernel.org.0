Return-Path: <linux-scsi+bounces-18446-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77457C1043A
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Oct 2025 19:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B113E3AAA3B
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Oct 2025 18:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E67E3328F9;
	Mon, 27 Oct 2025 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="UZ0ihYhn"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E7C332901
	for <linux-scsi@vger.kernel.org>; Mon, 27 Oct 2025 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590820; cv=none; b=VO4sHnXGf68gv4QTy0MF5p0LSKQcriJunistrlWXASHhXnWOMq+Gb4+B6lmKMhMYBUgmRFgTDVEIHTxEqDbn2d65PrCbTfrNkiRt3/+kGDRJiYkuU746WG5vuNONSoC4FSNS1A0LcyXx364W0YCtWvhbGZC6l99hFt4YUHtbXXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590820; c=relaxed/simple;
	bh=9YujQSHVaJ3iNLhvPFG7qk52LM4tkkLIJ9U3GQPUJeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LSdlGFKXSUPasCYHCVB6LuD3JtfiJAN6yACAYVXdKut6ft2KnCEQ/aV3aceg1AQ2We8TYE5senJtvMqbNz1yPVmRuJ/txBa8HWClZmcE4pOAby3eZ/AJN+IVHC0+2Eu3KKEDPRc2dp6uTt3xpaR8WuW651cXu2VYUSF42+BO8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=UZ0ihYhn; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cwMtQ2TFxzlgqyM;
	Mon, 27 Oct 2025 18:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1761590813; x=1764182814; bh=WBm8lyoyRPLnLUcJFjj5wVp+HHePum49nth
	uHBblXEQ=; b=UZ0ihYhn9Q7TFlMxAXBgZ0a5DPi8ZFCyiyXjBSetJm+EkD+HCcB
	yAP5ZsYDfofpEK5+ixEeVP4qETv9DgJ9XnZw5jPtoZ6vz7GMJOjmt82c3Pqc++AP
	SPPgIpxJhWhAw+nCOnCFStOTAUshWB19cXkIq38gsKG3khwkqP/DflL/ygkqMJjs
	pgXYDsnNp9SiegslXuasNjBjUoD2yzWkgoeEAHu40YgGoYmKZEw5rv8Lsl1DGe/k
	oHjFiKGemiiSt67PEDgnC2C54GczXcLcD6y7TRPFNRQ6qgxSOVcIdPfdMOBU7iBH
	527sGlbdjVusqhkWLedGrD0g2TN4Y9cM6dg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tZPDdpjMFvov; Mon, 27 Oct 2025 18:46:53 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cwMtM4sBjzltw93;
	Mon, 27 Oct 2025 18:46:50 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] Improve a SCSI target configfs show function
Date: Mon, 27 Oct 2025 11:46:37 -0700
Message-ID: <20251027184639.3501254-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

A recent security fix made me take a closer look at target_lu_gp_members_=
show().
I found one bug and also noticed that this function can be simplified. Pl=
ease
consider this patch series for the next merge window.

Thanks,

Bart.

Bart Van Assche (2):
  scsi: target: Do not write NUL characters into ASCII configfs output
  scsi: target: Simplify target_lu_gp_members_show()

 drivers/target/target_core_configfs.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)


