Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8811FC479
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Jun 2020 05:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgFQDKP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 16 Jun 2020 23:10:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41116 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgFQDKO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 16 Jun 2020 23:10:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05H39Wc1003328;
        Wed, 17 Jun 2020 03:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=2iifAA7LXdJY4pu2PHS/0St9g5q/kdBP2zmimA0tqDY=;
 b=Zyemp9H03I/ko0dYfJGLfSWjVh76absuTVgIE0KJcp4RU+ofladSATuGM9oxayEpmBSb
 PDYd5HJHgsj6jBSRRA3Lwvp/S2wNmi4yg6yFvPmD+yABkCTCEkDFjM5Mahx0tnu6UOE4
 9COkx4iEj2WUPy/wCGrDqNnj0Rgmcrwat17agcZPALXzCrVhuieNcBGu2yiddaC/eqHM
 VdWMtbTgSQbw6y6lhUt9yZ1r7nx/kWaz7TXZ4B3e7YbT+LDon70LuflgdQpmzXuydUax
 o6rO7TQ/EULOvFeZYBuTTomUbCoPoUrIYOoOELKwi1sDpeMsBvcI31Dtka1rLKJCGdl6 ig== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31q65yrre1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Jun 2020 03:09:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05H396V6146329;
        Wed, 17 Jun 2020 03:09:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31q66mpvce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jun 2020 03:09:33 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05H39LlP003047;
        Wed, 17 Jun 2020 03:09:21 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jun 2020 20:09:20 -0700
To:     Chris Boot <bootc@boo.tc>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux1394-devel@lists.sourceforge.net" 
        <linux1394-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chuhong Yuan <hslester96@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] scsi: target/sbp: remove firewire SBP target driver
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1366ul8o4.fsf@ca-mkp.ca.oracle.com>
References: <01020172acd3d10f-3964f076-a820-43fc-9494-3f3946e9b7b5-000000@eu-west-1.amazonses.com>
        <alpine.LNX.2.22.394.2006140934520.15@nippy.intranet>
        <7ad14946-5c25-fc49-1e48-72d37a607832@boo.tc>
        <alpine.LNX.2.22.394.2006150919110.8@nippy.intranet>
        <8da0c285-d707-a3d2-063e-472af5cc560f@boo.tc>
        <alpine.LNX.2.22.394.2006161929380.8@nippy.intranet>
        <8cbab988-fba7-8e27-7faf-9f7aa36ca235@acm.org>
        <SN4PR0401MB35982D889857E3C03E96E49D9B9D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
        <1592321667.4394.5.camel@HansenPartnership.com>
        <5e512185-45d1-61eb-9bec-91e9f9d53ea3@boo.tc>
Date:   Tue, 16 Jun 2020 23:09:16 -0400
In-Reply-To: <5e512185-45d1-61eb-9bec-91e9f9d53ea3@boo.tc> (Chris Boot's
        message of "Tue, 16 Jun 2020 18:59:58 +0100")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9654 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 suspectscore=5 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006170024
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9654 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 clxscore=1011 mlxlogscore=999 suspectscore=5 impostorscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006170024
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Chris,

> I don't especially want it to be gone, nor can I be sure there are no
> users of what is as far as I can tell a working piece of code. I can
> tell you that I never hear about it (other than the odd patch),
> whereas I do get emails out of the blue for some of my other (much
> smaller) stuff which clearly has users. I'd be just as happy for this
> to be orphaned or for nothing to happen to it.
>
> Honestly, I am totally ambivalent as to what happens to this code.
> Martin, however, clearly cares enough to have asked me to supply a
> patch to remove it.

I love it when people take ownership of old drivers. I think it's
wonderful that Finn and others are on the ball when it comes to the 5380
family. I don't care how old things are as long as they are being
actively used.

I am also very happy to keep things in the tree as long as there is a
healthy community around them. However, keeping code around is not
free. Core interfaces change frequently. Nobody enjoys having to tweak
host templates for 50 devices they have never even heard about. Also, we
now live in a reality where there is a constant barrage of build bots
and code analyzers sending mail. So the effective cost of keeping code
around in the tree is going up. I get a substantial amount of code
analysis mail about drivers nobody have touched in a decade or more.

Consequently, I am much more inclined to remove drivers than I have been
in the past. But I am also very happy to bring them back if somebody
uses them or - even better - are willing to step up and maintain them.

I don't particularly like the notion of a driver being orphaned because
all that really means is that the driver transitions from being (at
least partially) somebody else's problem to being mine and mine alone.

-- 
Martin K. Petersen	Oracle Linux Engineering
