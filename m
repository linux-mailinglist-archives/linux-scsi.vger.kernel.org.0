Return-Path: <linux-scsi+bounces-794-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A960380BCB9
	for <lists+linux-scsi@lfdr.de>; Sun, 10 Dec 2023 20:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4761F20F27
	for <lists+linux-scsi@lfdr.de>; Sun, 10 Dec 2023 19:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507E51BDDF;
	Sun, 10 Dec 2023 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="jNsuALSK";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="2Gekm8XQ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3F5E8;
	Sun, 10 Dec 2023 11:28:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702236502; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JNtPHzZleLURB8MLrU4m3gfUTywC87olz8rBDgzUhEm6AfJ9Nptk+42ZjSI34GPFZW
    klvSW610Vqo96juHeL5xLyY0MC9Nz94oC/njGTWoUwS8XtoXJXNWfBtfRogRRoH2IoP5
    3BWKYqwM2DsffwCLt/SXKJOnZpOcvUYSNyUpWMLGIOnJMdGL0rLy4nPD8IAgJeY71s/R
    P1IFAxqpwyxmGcqCDHxLfpv3gznsD7Xt289vb5QRO5BFqOnvGyMlFfT8F5K4DPlGFN7O
    zQk5I7dlM9/NBBRGeI/sF9CsWmaliw4QNmbdHxOmvbxQavuJuC4wtnoW3E8vu0FdFw3T
    /sVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1702236502;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=JzuwNz2m2BHZRXieTg2amEf06Pg1H0ACs/yF9X1xMkU=;
    b=NpBY7caJ9YJoZyzv3cUfAj1fMW2iDfys6LI248vePK+KnmTGedsJQTGT33hVtWEGNE
    DOMJvRnxjUBDzHnYwg9KATipZIMpeXsk4GGu8GqjSE5/6bmcPr3kFA39Y+SiCnjuL9vC
    Y53Ha29OW7tLaeZeB3Y0Om14fPK+o/BpffcA+Nv6v29pvOA2P/Q6Dc2SAiyWq+5v3nsT
    /YRcMojPtwUXxv4v5u2fjl9YBmzUmOv13tdFh6Kc6V7qqAsiQShexZOTbQNPbQcB5er1
    7AnJq2t6XrXNKqujSFaD0BFEHkAns4SGfiobJDN4e2kEBR5kUVOQ2tSAUy9f4lDR2JWh
    tuOg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1702236502;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=JzuwNz2m2BHZRXieTg2amEf06Pg1H0ACs/yF9X1xMkU=;
    b=jNsuALSKroKpZj85lkx2SltdyAA2qmIbTZ3lCIfU5xlLcj4ra0YiElQ1XQYngIa6B3
    Ow7k9pcSaE5zk7KzuLD0h76m894lW+61dUas6cCFockQJysz2XeoFUn0LKWGUGp7t9rP
    MJRxosaXWVLkAKe093qElB+NH0roZTscRftbtO4tsAV7j5hpPq+WcIigF4KtfbkdHgSN
    eZ59VgO00w3g19/il0OaBnDWvy7BfpF9RduwjFYKW3V6/ILJKHZBYEonCKcu3zNfiH9T
    6PEf0GgkSWtj6CZdwVsqdJloWrNu5QUnKsmDXTw2X8WEgJwBTWbEUNZp+ORn2skxC57D
    u0aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1702236502;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=JzuwNz2m2BHZRXieTg2amEf06Pg1H0ACs/yF9X1xMkU=;
    b=2Gekm8XQ8yOEiECsyL0L/xPHQrDvshxdGuz1qv9lRGVXfiqDSResHWzvFaOPD1rN1G
    S+Zaeo4z6dTOMlpXQjBA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JyMI1zXvWpofGAS3nPdhoJ/jk9323l/f/nGBvH+kduPjVfkLDvw="
Received: from p200300c5872edccdd83ccf3bdf7838cc.dip0.t-ipconnect.de
    by smtp.strato.de (RZmta 49.10.0 AUTH)
    with ESMTPSA id z4c2a6zBAJSLFR6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 10 Dec 2023 20:28:21 +0100 (CET)
Message-ID: <fe5eacf2016622f4f3335a1d39063ec523999184.camel@iokpp.de>
Subject: Re: [PATCH v4 2/3] scsi: ufs: core: Add UFS RTC support
From: Bean Huo <beanhuo@iokpp.de>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com, 
 jejb@linux.ibm.com, martin.petersen@oracle.com, quic_cang@quicinc.com, 
 quic_asutoshd@quicinc.com, beanhuo@micron.com, thomas@t-8ch.de, 
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 mikebi@micron.com,  lporzio@micron.com
Date: Sun, 10 Dec 2023 20:28:21 +0100
In-Reply-To: <20231208170609.GD15552@thinkpad>
References: <20231208103940.153734-1-beanhuo@iokpp.de>
	 <20231208103940.153734-3-beanhuo@iokpp.de>
	 <20231208145021.GC15552@thinkpad>
	 <89c02f8b999a90329f2125380ad2d984767d25ae.camel@iokpp.de>
	 <20231208170609.GD15552@thinkpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-08 at 22:36 +0530, Manivannan Sadhasivam wrote:
> Except that the warning will be issued to users after each 10s for 40
> years.
> Atleast get rid of that.

how about using dev_warn_once(), instead of dev_warn, using
dev_warn_once() ensures the warning is issued only once.


diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 953d50cc4256..b2287d2f9bf3 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8205,7 +8205,7 @@ static void ufshcd_update_rtc(struct ufs_hba
*hba)
        ktime_get_real_ts64(&ts64);
=20
        if  (ts64.tv_sec < hba->dev_info.rtc_time_baseline) {
-               dev_warn(hba->dev, "%s: Current time precedes previous
setting!\n", __func__);
+               dev_warn_once(hba->dev, "%s: Current time precedes
previous setting!\n", __func__);



Kind regards,
Bean

