Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10721D0DF
	for <lists+linux-scsi@lfdr.de>; Tue, 14 May 2019 22:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfENUxn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 May 2019 16:53:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54158 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfENUxn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 May 2019 16:53:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4EKhnYL136007;
        Tue, 14 May 2019 20:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=VV+NzNKRQ92hTIqyAMv9xDly31wveTg6YswLEVBa6dU=;
 b=P9oQWfWCIftOQ1+IMLfFZ2uD8QNLkB1mKl0CwYl+I/1cCDjrFTEWRiGLvf5LRfiHCmnr
 Ou/Vh4wKTyTW4sYZ9GC9cNR++GIBvJ0H2HkWQQbja3Kik0YbxnKOl3oC/9E+R1qd4crJ
 fr8t8/EpNmFB6MmLZA6kKztslc+0DM85mKTGnJKnyxLzpd6urG0m8bSWuDTtB0OPF0Mm
 qPxst8mC40BFaAL/9311c+Ys7t9mCBeiQuOfuBVKqFCdoVVmMOi10KarqpPVjOnwwQjo
 FU7Jefswj0yvBSSNGbyM4WcrnLNN/k8k/g6/R8TmwmDR1zXbnPV/xnXRPORIwIlQJHFC Zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2sdq1qgqew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 20:53:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4EKqha3188907;
        Tue, 14 May 2019 20:53:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2sf3cngq5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 20:53:32 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4EKrR60020022;
        Tue, 14 May 2019 20:53:27 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 May 2019 20:53:26 +0000
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/2] sd: Rely on the driver core for asynchronous probing
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190430213919.97437-1-bvanassche@acm.org>
        <yq14l5xdknh.fsf@oracle.com> <20190514205129.GA29109@amd>
Date:   Tue, 14 May 2019 16:53:24 -0400
In-Reply-To: <20190514205129.GA29109@amd> (Pavel Machek's message of "Tue, 14
        May 2019 22:51:29 +0200")
Message-ID: <yq1mujodagr.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905140139
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905140138
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Pavel,

> Previous versions broke suspend for me on x60... so I guess I should
> test -next tommorow or day after that to see if it works now...?

I won't push the 5.3 staging tree out until the merge window is over
early next week. But it would be much appreciated if you could verify
Bart's fix.

-- 
Martin K. Petersen	Oracle Linux Engineering
