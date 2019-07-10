Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3C863C27
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Jul 2019 21:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfGITtF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 9 Jul 2019 15:49:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50298 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfGITtF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 9 Jul 2019 15:49:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x69JmwqP026550;
        Tue, 9 Jul 2019 19:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=CmQbH8XJlLLeBfq76uQ18uqsTOTGRsTpvEFjktn/zmM=;
 b=KpUMySPyViEgkkaX/oUCUDyBS+C6O6Ic+0ZPNXD5H8Zxin2skZzqyvdWXkAWc/hB1kM/
 JzRxAvllvQ7oeqo3ydMr6kGqTapDOrkL4b/RQpz4QZSEREPhsB4hDenAkY68l8Buhr38
 HY5L35HcOXmrdOVMWskHGYLnEnmGTOJWCxVFrhmaQyQt5Q44p4udPxfH5TkEkgysbZqs
 jDpzi7JuqVFXxotGzxBqEJ+Eem7zUgybHNSY6llK4wBU7enr8Wg0onqrsY8g09VnwSD4
 feoQzR/FAtYU+PSa32TFq6azgTR0gZ5b5yuJ8/NRHMqx2EDgpXNefmDG+svQ2Ox8iy7K YQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2tjm9qp8us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jul 2019 19:48:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x69JmAnq137219;
        Tue, 9 Jul 2019 19:48:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2tmmh35b4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jul 2019 19:48:54 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x69JmntI020580;
        Tue, 9 Jul 2019 19:48:52 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Jul 2019 12:48:49 -0700
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.2+ merge window
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1562699693.3362.93.camel@HansenPartnership.com>
        <yq1lfx7c80r.fsf@oracle.com>
        <1562701406.3362.105.camel@HansenPartnership.com>
Date:   Tue, 09 Jul 2019 15:48:46 -0400
In-Reply-To: <1562701406.3362.105.camel@HansenPartnership.com> (James
        Bottomley's message of "Tue, 09 Jul 2019 12:43:26 -0700")
Message-ID: <yq1ef2zc7kx.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9313 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=721
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907090235
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9313 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=790 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907090235
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


James,

> Actually, I was planning a second pull request for that one.  I
> presume you think it's ready to go?

It's spent 3 weeks in -next without any complaints.

-- 
Martin K. Petersen	Oracle Linux Engineering
