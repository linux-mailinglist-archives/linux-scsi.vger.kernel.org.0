Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 407533839F
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 06:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfFGE7C (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 00:59:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37438 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGE7C (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Jun 2019 00:59:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x574rmVI162842;
        Fri, 7 Jun 2019 04:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=peDNI+NIz4MnQeyOvf7gO3AaP/o30YLoHHRfspxl5eQ=;
 b=0DxzJ8kbJcvmwDkwQXH2FZMp86QITROwOzoPBO1JX/gEWlfPWbSZsi5bpoQ8BgVitt4/
 wHSTpAoH8B7JeuZGD7pWOA3nXEjClFxg/5QHfWrYGMElx2eh/5b6Qbtv+vunXZ/Uhz0Z
 KZb5I76ccdH4FFuB6bcd8VqYeSGimwJIfNfDKWjQWNGNH5IUHe9vUQET48DEqUAZT1he
 Eohb/WcIoSSrUr+sLAaP8qCvdR5hpIExHKmahQvzJBTILx9hUjxhN9nVLx+WeI/d+Ueh
 2n4mj4F0pvFiGh/+PDNnY5MGouW8rGrTXP0B4OIFYwEEMMBfAGl6XCJclBc5CEmJwfxI Pg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2suj0qv0m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 04:58:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x574vwbu109539;
        Fri, 7 Jun 2019 04:58:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2swngjtg5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 04:58:52 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x574wmhA027386;
        Fri, 7 Jun 2019 04:58:49 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Jun 2019 21:58:48 -0700
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, jejb@linux.vnet.ibm.com, hare@suse.de
Subject: Re: [PATCH 00/19] sg: v4 interface, rq sharing + multiple rqs
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190524184809.25121-1-dgilbert@interlog.com>
        <038d4781-1762-d7f6-199d-2f4702e746f6@acm.org>
        <4bebc171-55b9-5c41-0a7e-51db22473a03@interlog.com>
        <yq1muiuok9f.fsf@oracle.com>
        <9e8a020e-c014-733d-11b4-986e5aefd877@interlog.com>
Date:   Fri, 07 Jun 2019 00:58:46 -0400
In-Reply-To: <9e8a020e-c014-733d-11b4-986e5aefd877@interlog.com> (Douglas
        Gilbert's message of "Thu, 6 Jun 2019 18:42:17 -0400")
Message-ID: <yq1y32ekn3t.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906070034
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906070034
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Doug,

> So tl;dr ?

I actually tried.

I also spent some time reading the patches two weeks ago. The new series
is an improvement over the initial sg v4 posting from last winter. But
it still needs work.

> Also if my sg v2/v3 documentation targetted the kernel submission
> processes between 1998 and 2002, would it be much use today? I think
> not.

No, but a diff, change bars, or something similar would have been very
helpful to clearly identify what's changed between v3 and v4. Just like
it's done in standards documents.

You have your section 3 bullet list. But the rest of the document is
huge and it is not immediately obvious what the v4-specific bits are.

> Thank you for repeating the party line. I expected none other.

Don't shoot the messenger. This is all documented in detail in:

      Documentation/process/submitting-patches.rst

Please adjust your patch submissions accordingly. Especially the first
few paragraphs of section 2 in that document are worth paying attention
to. Your patch descriptions typically don't have a problem statement or
justification. Why are you making all these changes? Why do we need a v4
in the first place? Why don't the existing ioctls suffice? Why aren't 16
outstanding requests per fd enough? Etc.

> And where are the design documents for the sd driver and its ongoing
> evolutionary changes? Ever seen anything written about the sr or ses
> driver?

I think you are missing my point. We don't have gnarly design documents
because every change is either a self-contained commit or small series
where each patch describes why a change was made. The git log *is* the
design document.

Each of your bullet features in section 3 ("Changes to sg driver between
version 3.5.36 and 4.0") would ideally be submitted as a separate patch
series whose individual merits could be discussed on the list.

This is in sharp contrast to the "This patchset is big and can be
regarded as a driver rewrite" approach that signals a preconceived
commitment to a particular set of features and design choices. Why
comment on something you can't influence? Who has time to read 22K words
on a website and try to find out how those words relate to the posted
patches?

The only person on linux-scsi that *has* to look at your patches is
me. Everybody else is a volunteer you need to entice to invest time and
effort in reviewing your work. Quite possibly in their spare time.

That's why I suggested that the burden is on you. You need to present
your work in a way that engages people, is manageable in terms of time
commitment, and makes them feel their investment is worthwhile and
appreciated. Please take that into consideration.

-- 
Martin K. Petersen	Oracle Linux Engineering
