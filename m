Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD02662DE
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jul 2019 02:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfGLAba (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Jul 2019 20:31:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46510 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbfGLAba (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Jul 2019 20:31:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C0U0Oa090472;
        Fri, 12 Jul 2019 00:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=/yUkV2kcQZMuUUaMsK8yTgSJT7TPdq7wzk+pQE3iXB0=;
 b=2l6lvmcrKRTZuVBHrYxuebWgm74j03ECUGUFZdISHgklHYIxZYqctP62BDk9nVFEeKXM
 aujSAFshm+T5L86+rQ7uG8hD0hqmgYIM4epaM/F6rV5u5VK0K58TsLziW54prU25ewRd
 tTtFSMg3/PZqh/NhUPSf8tOuQjUsRw6DqIjMo476D1zU1FCT2FGm31AVvurqSzbg2CVn
 knEOz6m5nx8+8ILtRx3ooRKZbU7/U/tBtAoIkVqrQBHTyzsNHpeUc49ddg1tOJ9olcXy
 VzEpkLEbMOUlNAWVCSYy8A+l/x6pP5NFH7tlbuiankJR40vaZXru9MeS9512s3sR5gu+ qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2tjm9r2u1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 00:30:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C0RV7Z041050;
        Fri, 12 Jul 2019 00:30:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2tpefcsmkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 00:30:55 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6C0UsQ5016250;
        Fri, 12 Jul 2019 00:30:54 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jul 2019 17:30:54 -0700
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: use scmd_printk() to print which command timed out
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190702112705.30458-1-mlombard@redhat.com>
Date:   Thu, 11 Jul 2019 20:30:52 -0400
In-Reply-To: <20190702112705.30458-1-mlombard@redhat.com> (Maurizio Lombardi's
        message of "Tue, 2 Jul 2019 13:27:05 +0200")
Message-ID: <yq1o920856r.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=910
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=973 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120004
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Maurizio,

> With a possibly faulty disk the following messages may appear in the logs:

Applied to 5.3/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
