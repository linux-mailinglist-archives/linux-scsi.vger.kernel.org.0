Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7733B376DB
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Jun 2019 16:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfFFOft (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Jun 2019 10:35:49 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45978 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbfFFOfs (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 Jun 2019 10:35:48 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56EY06F124522;
        Thu, 6 Jun 2019 14:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Q4yGvNoqJlS0nCCwOP9r4Ygg8zP/A2W4xwnECCwg2IA=;
 b=vDZ8eIYpCIVnQzQM5UQ86UGJckv4yclVBuZtt13ZLhfk0ggJqH6y2EqlzxDOGyqlcdAb
 rWVdVfAw6YatILp4oQKCg04iRsaxFxk4zUPXA+rS10kDgrUhqLWsDx04kDCnEh+bqdO9
 iEsWIBTP1KVvgqKvDD/ipAyPxqFChWIAoTyO2MDq3AiX/sx2pqGLcQg1tbXIFF8VQppm
 PIs7piL2O8AW+K/IyhxHkVsDRrgSQPman1LkGzH281NKXJUqEoqvT+90zcEg2HdwbbhG
 w1ynSgBQ1rW0byxyh5Er7aYg7opi2DwS7yE9sEh6tj33GR5q2eXD3s5097kc5fTQI3Yl Vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2suevds4dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 14:34:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56EYYR8059656;
        Thu, 6 Jun 2019 14:34:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2swnhasmmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 14:34:34 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x56EYSe6017487;
        Thu, 6 Jun 2019 14:34:29 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Jun 2019 07:34:28 -0700
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de
Subject: Re: [PATCH 00/19] sg: v4 interface, rq sharing + multiple rqs
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190524184809.25121-1-dgilbert@interlog.com>
        <038d4781-1762-d7f6-199d-2f4702e746f6@acm.org>
        <4bebc171-55b9-5c41-0a7e-51db22473a03@interlog.com>
Date:   Thu, 06 Jun 2019 10:34:20 -0400
In-Reply-To: <4bebc171-55b9-5c41-0a7e-51db22473a03@interlog.com> (Douglas
        Gilbert's message of "Tue, 4 Jun 2019 17:31:16 -0400")
Message-ID: <yq1muiuok9f.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906060102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906060102
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Doug,

> Cutting a patchset that touches around 1500 lines of a 3000 line
> driver, then adds new functionality amounting to an extra 3000 lines
> of code (and comments), according to the "one change per patch" rule
> would result in a patchset with hundreds of patches.

The problem here is that you think of it as a single patch set
transitioning the driver from major version X to version Y.

Linux kernel development has moved away from that model. The kernel
release cadence is more or less fixed at 10 weeks. The release process
is not controlled by features or component versions or anything of that
nature. It is set by passing of time.

The notion that a driver or kernel component may have a version number
applied to it is orthogonal to that process. A version is something you
as a driver maintainer may decide to use to describe a certain set of
commits. But it has no meaning wrt. the Linux development process.

If you want to transition sg from what you call v3 to v4, then the
process is that you submit a handful or two of small, easily digestible
patches at a time.

It may take a few kernel releases to get to where you want to be. But
that is the process that everybody else is following to get their
changes merged.

Nobody says you can only make one submission per submission window. It's
perfectly fine to submit patches 11-20 as soon as patches 1-10 have been
reviewed and merged. As an example of this, the HBA vendors usually send
several driver updates each release cycle.

> Further if they are to be bisectable then they must not only
> compile and build, but run properly.

Absolutely. That's a requirement.

> Of course that is impossible for new functionality as there is little
> to test the new functionality against.

The burden is on you to submit patches in an order in which they make
logical sense and in which they can be reviewed, bisected, and tested.

> I looked at the "Device Drivers" section. Most patchsets there
> had between 10 and 20 patches, one had 33.

The "number of patches in a driver submission" as a measure is a red
herring. sg is not a new driver, it has users.

> One, the SIW Infiniband driver, is over 10,000 lines long, and
> contains 'only' 12 patches.

But it was presumably developed out of tree in a separate repo. And the
thousands of commits that resulted in this driver have been collapsed
into 12 patches for initial submission.

The number of lines is also a red herring. If a patch changes 10,000
lines to make one logical change that's perfectly fine. What's not fine
is a patch changing 10,000 lines and also making an entirely different
logical change.

> Reviewers are obviously a scarce resource, but making their live's
> easier shouldn't be a goal in itself.

Couldn't disagree more. If you want your code merged, you will have to
present it in a way that caters to the reviewers. Because without
reviews, your code won't get merged.

> If new functionality is being proposed, surely it is better to check
> that it is documented and that test code exists. Then the design and
> high level details of the implementation should be assessed.

Testing and documentation are absolutely important. But so is
documenting what compelled a code change.

Reviews aid in verifying that the thought process outlined in the patch
description matches the code changes performed. This is where the whole
"one logical change" comes from. And when things subsequently break, it
is then easy to identify which assumptions the patch author made that
turned out not to be valid.

> To date I have had no feedback about design document describing this
> patchset: http://sg.danny.cz/sg/sg_v40.html

This suffers the same problem as your patch series in that it
encapsulates 26 years of thought in a single blob.

Presumably that document developed over time and didn't go from nothing
to 22K words in an instant. You need to document that process. Also,
having a design document that describes a wealth of changes after the
fact is not terribly helpful.

I understand appreciate that you are focused on the end product. But to
get there you need to slowly and iteratively submit patches against v3
that can be independently reviewed and merged.

Please pick one feature at a time. Carve that into a few patches that
each logically only do one thing. And then submit that as a patch set
with an intro mail that describes the design of the feature, which
assumptions are made, what the benefits are, who needs this capability,
etc.

-- 
Martin K. Petersen	Oracle Linux Engineering
