Return-Path: <linux-scsi+bounces-718-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F09580974B
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Dec 2023 01:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7BE71F20F7C
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Dec 2023 00:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24721139B
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Dec 2023 00:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="Cmy9jwCG";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="v5unjEUo"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4141710;
	Thu,  7 Dec 2023 15:02:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701990155; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PP4IttObG06Nbg9S4wT+xCyoX84/2iUUoUdjjS4ke+G6A+/ebrh8zhcniSIn79mQ5B
    LSawalD7Zpn5OohQomh+HbfzAr4/dD6V10vlLDz0KYjBkQVeSPMh0e0XXnTHNaBjJkx8
    T5GYxAoFnRO99cDQn5RXSRLh5sFQM3r+z5FNVHl8nZX/3OR4aa2cgPb0a03SGAIwupGc
    VayRlPi5ktLj8YkS7yh2l7Twlk1Ex27Xute9eQBXBSDfGL1msB4HqBeyRJi8d26CE6bb
    YJ62d7fKsLORm52gNjb7sR3E3yTYikLWkZiv8d0Z++6h9r0cJ2KWzl4RlmWqFrViSNtt
    w8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1701990155;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Inp95GW9nBAjNnHuUAANWe74go/YXaLvNxyxI6q8r/U=;
    b=PgThVsVlyHZPOm+V/lj8B97jgZDDu5mLBjIT8hlv1l+mG6U5PiSRXvWMgNzZXeTiGY
    eqtVNHBufQDALPAXG9hdJrTnEs7lWmNlvD5esbZG5Ze9jAGE9SKiqvS4CEDMu/hxubGc
    6pA273bbodE1ORtCoPCcGK6/+7eMEvzU7TcSLemJBLufu7FKwhEpXLG9FCyBzqibsUvy
    0+e7tIMOiPD+qgkHnAmv1S2FxgjVPjztG2WlhBn/DibIQtRMSt7nuykSDmt7/f4Qf1yE
    TIcruRynbABSuplFFEEeF7GonUjnzjz0EQIAjdYaZoNSvf861VeIYUsoK4dwKCDiuwC+
    g7Gg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1701990155;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Inp95GW9nBAjNnHuUAANWe74go/YXaLvNxyxI6q8r/U=;
    b=Cmy9jwCGqVdOrPmpn4YzPMJKpPtDNHKinG3cev3QrjIZpvExG70HbKDYJlPQkjy6vy
    3aDwyWceMxA/GfaewJOda2gH3Ue2k49peJgvp+pm08RxiZ1DvQUSRHcuw9PSBwp2GvDP
    M3tX4I79SOXdXEA4AjAyDz6Q+7dIFT6vtyxvTIaLKK8nmYV4xp1QpgnrMxDZ43gjAgR+
    9Qui8F92MSa6GUlWngWQ5o2bCo1rjGdKOBy5pdqxKlsxuel2pPgjaDqaxs7GHe/etxL+
    nu8CPT79i/9qvW3usXQvDK0umhv+d7/IV2nKGCkPL6yLnLOIWrQqN1AXtCFuULmFfhMI
    f8hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1701990155;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Inp95GW9nBAjNnHuUAANWe74go/YXaLvNxyxI6q8r/U=;
    b=v5unjEUoDX3NyGzuXMi+K2Xs31IF5nT5nWyL06J+Q7LGlAzRuChUrbjaB9TI2iu01e
    dR42hr8CfQtkPIlpySCw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JyMI1zXvWpofGAS3nPdhpsrjz9a9vtSST6HKPUHFmsUnlCzixmg="
Received: from p200300c5872edce18348648ab5312731.dip0.t-ipconnect.de
    by smtp.strato.de (RZmta 49.10.0 AUTH)
    with ESMTPSA id z4c2a6zB7N2XACO
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 8 Dec 2023 00:02:33 +0100 (CET)
Message-ID: <887dec18bdaec3cc048f0f4d5c0391dc338e3828.camel@iokpp.de>
Subject: Re: [PATCH v3 2/3] scsi: ufs: core: Add UFS RTC support
From: Bean Huo <beanhuo@iokpp.de>
To: Bart Van Assche <bvanassche@acm.org>, avri.altman@wdc.com, 
	alim.akhtar@samsung.com, jejb@linux.ibm.com, martin.petersen@oracle.com, 
	mani@kernel.org, quic_cang@quicinc.com, quic_asutoshd@quicinc.com, 
	beanhuo@micron.com, thomas@t-8ch.de
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 mikebi@micron.com,  lporzio@micron.com
Date: Fri, 08 Dec 2023 00:02:33 +0100
In-Reply-To: <b5819922-60e0-4701-84d4-05c76d2ea5ec@acm.org>
References: <20231202160227.766529-1-beanhuo@iokpp.de>
	 <20231202160227.766529-3-beanhuo@iokpp.de>
	 <b5819922-60e0-4701-84d4-05c76d2ea5ec@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-06 at 14:59 -1000, Bart Van Assche wrote:
> A 64-bit value is truncated to a 32-bit value. What should happen if
> the
> right hand side is larger than what fits into a 32-bit integer?
> Should
> a comment perhaps be added that uptimes of more than 136 years are
> not
> supported and also for absolute times that the above code fails after
> the year 2010 + 136 =3D 2146?
>=20
> Thanks,
>=20
> Bart.


Bart,

you are taking into account a broader perspective. thanks for your
review!

I will add below code in the next version:


+       if  (ts64.tv_sec < hba->dev_info.rtc_time_baseline) {
+               dev_warn(hba->dev, "%s: Current time precedes previous
setting!\n", __func__);
+               return;
+       }
+       /*
+        * Absolute RTC mode has 136-year limit as of 2010. Modify UFS
Spec or choosing relative
+        * RTC mode for longer (beyond year 2146) time spans.
+        */


Kind regards,
Bean

