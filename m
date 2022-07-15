Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91657576A3D
	for <lists+linux-scsi@lfdr.de>; Sat, 16 Jul 2022 00:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiGOWw3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 15 Jul 2022 18:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiGOWwO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 15 Jul 2022 18:52:14 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Jul 2022 15:51:58 PDT
Received: from mx01.oniris-nantes.fr (mx01.oniris-nantes.fr [193.48.2.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD148EEC0
        for <linux-scsi@vger.kernel.org>; Fri, 15 Jul 2022 15:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=oniris-nantes.fr; i=@oniris-nantes.fr; q=dns/txt;
  s=onirissmtprelay; t=1657925519; x=1689461519;
  h=mime-version:content-transfer-encoding:
   content-description:subject:to:from:date:reply-to:
   message-id;
  bh=AQd2ojwH61akYClB9q7V/X50pC8tSyoSWQn6ZMhvUxY=;
  b=CAoFPwrMOtSJW5N9w0RYPNcQcNckXiuiDaod/lq3/6kuPg7qCQ7bukgv
   Z+EEx+iOzWYRJS7OxApRRwSh3UN/5D+tAGIVOcogTLp9ZoGqVRfJaEjw1
   jEvJQTXmVlDr1k/lclJPFxETJ2BwE87FNrLECTmi4nvzIRFwvoS/mPXpG
   tkeIx+GDDabK4s8JShpHPffTAy4xTWy5tZuS12c7PyVB30nHkBF7GKsu8
   vhEaZ5wMtuBUOLOUF3c/nfrvTW/JYd5qujqK5HS3pct2EKsOjJHEQ5OMc
   DOq9M+mcs8rlFjxRxdy3eZY0LDrp/3IdY/svyKcZFdL6a2Js3g2tJAoHn
   g==;
IronPort-SDR: SbFTf4WbX3DLudztwXHUawb9r9Tk5qIllNgAiwm3oZCdPkao4HvC62Tn2pFaihGQi1DMtbojEh
 i/+mj74EeMHw==
Received: from srv-rproxy-01.oniris-nantes.fr ([193.48.2.222])
  by mx01.oniris-nantes.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 00:50:54 +0200
Received: from localhost (localhost [127.0.0.1])
        by srv-rproxy-01.oniris-nantes.fr (Postfix) with ESMTP id 38A672035C;
        Sat, 16 Jul 2022 00:50:53 +0200 (CEST)
Received: from srv-rproxy-01.oniris-nantes.fr ([127.0.0.1])
        by localhost (srv-rproxy-01.oniris-nantes.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aJoDZtMkyi4c; Sat, 16 Jul 2022 00:50:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by srv-rproxy-01.oniris-nantes.fr (Postfix) with ESMTP id CD1CC2030D;
        Sat, 16 Jul 2022 00:50:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 srv-rproxy-01.oniris-nantes.fr CD1CC2030D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oniris-nantes.fr;
        s=584628BC-C45C-11EB-88D3-95D0CF659A93; t=1657925452;
        bh=TwWkYl19ABnkv5SxTw1S0zUfrK6a15soWxaXxRYyNU8=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=Rd/XVdiHMLhr7xb+7DIQSbvIeqgnoUe/C8QYZDsime+is0J/e1mF+OOxZO9iNtj06
         Op3QoEKC23F5k5DZlVAD31gHAwqHHAsmbcPkPhb6Z5ac5a3MHMK1b4/+ohzH8iDQjj
         L10+MJ0iqvQieTCJNL1PlfrIywLLsJkJTU5ngozZMfe9V2wJvmxlY6668Qhdl1r1rH
         uurTjLXPW49g8n6UULe7+QcrQ9MEysWcBmAOvLt0m6+iUDEJaXmdmku480BcgJJKR+
         1mHWOd1de1mhhQ9l6ZOIJ4/oEtbc+nojNLJ7wZKoNW45RhfzkFt4RSUfE/1fU5JqrD
         lmhQJfnbMILBw==
X-Virus-Scanned: amavisd-new at srv-rproxy-01.oniris-nantes.fr
Received: from srv-rproxy-01.oniris-nantes.fr ([127.0.0.1])
        by localhost (srv-rproxy-01.oniris-nantes.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KLFEjTHJPiFa; Sat, 16 Jul 2022 00:50:52 +0200 (CEST)
Received: from [192.168.0.77] (unknown [197.184.178.189])
        by srv-rproxy-01.oniris-nantes.fr (Postfix) with ESMTPSA id 521F120348;
        Sat, 16 Jul 2022 00:50:48 +0200 (CEST)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: VERTRAULICHKEIT
To:     Recipients <julie.marie@oniris-nantes.fr>
From:   julie.marie@oniris-nantes.fr
Date:   Sat, 16 Jul 2022 06:50:44 +0800
Reply-To: silvanatenreyro1480@gmail.com
X-Antivirus: AVG (VPS 220715-4, 7/15/2022), Outbound message
X-Antivirus-Status: Clean
Message-Id: <20220715225048.521F120348@srv-rproxy-01.oniris-nantes.fr>
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_BL_SPAMCOP_NET,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Zu Ihrer Information: Wir haben eine Erbschaft in Verwahrung, die mit Ihren=
 Namen verkn=FCpft ist. Kontaktieren Sie Frau S. Tenreyro unter: silvanaten=
reyro1480@gmail.com mit Ihren vollst=E4ndigen Namen f=FCr Anspr=FCche

-- 
This email has been checked for viruses by AVG.
https://www.avg.com

