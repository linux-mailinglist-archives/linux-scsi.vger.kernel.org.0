Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDA347AD69
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jul 2019 18:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbfG3QTp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Jul 2019 12:19:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46052 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbfG3QTo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Jul 2019 12:19:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UGJ9gj017670;
        Tue, 30 Jul 2019 16:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=J9i9O8brzFXMV0nqss2WwKTrsOAVsDK3Op13gSR8wsA=;
 b=WTNbWnt2ueT4b5HtwJnjq4o8ApNJ9iwlUJc+wlEwUdJAeYoAH0SDGi39j8IVNXNCGGg+
 uMfPEFuSVrUvD94toHkEgKoejWClQqhJLEnBFB1A+q/YdJAPT43sKBMIIeyV6rc9vYSM
 yJlLrO2XWaYscKoLgZ31F9UYgePD/qdHxd5kJCfNiP7gtdv/AgEy5FMWLagHd5KUbkf2
 cd3YE8NPb1/+u4BGuEVI7cdZsuJsophA//pE/2JmyweUvBXQmTk7R0EimvnqgAtwLlyJ
 q4URrVEYjXg/WAuUZIxPz6m3puhXDvojvJ4tAfPHu+SKJxM+DZ2J5m99ueaJP5HrRWro XQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2u0f8qyj94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 16:19:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UGHZIf065558;
        Tue, 30 Jul 2019 16:19:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2u2exaag8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 16:19:40 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6UGJccR010382;
        Tue, 30 Jul 2019 16:19:38 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jul 2019 09:19:37 -0700
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Ondrej Zary <linux@zary.sk>
Subject: Re: [PATCH 0/3] Fix more magic values in the Future Domain drivers
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <a6fcf19e-d8ed-80c6-6d5a-53f143c08d99@cogentembedded.com>
Date:   Tue, 30 Jul 2019 12:19:35 -0400
In-Reply-To: <a6fcf19e-d8ed-80c6-6d5a-53f143c08d99@cogentembedded.com> (Sergei
        Shtylyov's message of "Tue, 16 Jul 2019 23:37:16 +0300")
Message-ID: <yq14l33o5pk.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=982
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907300169
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Sergei,

> Here's a set of 3 patches against the Linus' repo. The recently
> resurrected Future Domain SCSI driver got a facelift by Ondrej (thank
> you!); however, several magic numbers were overlooked, so I went and
> fixed these cases.

Applied to 5.4/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
