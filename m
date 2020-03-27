Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D582194EAE
	for <lists+linux-scsi@lfdr.de>; Fri, 27 Mar 2020 03:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgC0CAr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 26 Mar 2020 22:00:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38414 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgC0CAr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 26 Mar 2020 22:00:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02R1xR6E185099;
        Fri, 27 Mar 2020 02:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=6+loAL8FXEKnUok7C8nHVuCjib/Jl9TWyDWgWbbn35g=;
 b=BTcXxZa/QNCLIMl0uhsUkcvkkJdFuA9lmZ8CSi1uNXnhJ03UbUquk8+dK0GnT0o5XcRo
 pruX2QabIL4oOMbml3rQMsJmcq57kS2iyeAZV+5B38Xe5Fe/WgIlvco3ZfoDalptGGjZ
 uh3SiwO2LE+7j9dNYlCswJnqAE9uHQCMepiAIDAVpER/qqPrOatbGIUC+vNRha2tbEmF
 zT9EXxGV4BsEp2VMpM8VAMI3WvmMoU6vnfqpGoWoEFDuSLCgFIFvHaHOYYNTvSONexfb
 j+kgeSaZMjNBIwpRQy1nJ5HQn+uiSXhY2u8QeuwqsGw14DhkG3jINuNknigtfwHx0m8C Rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ywavmjwmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 02:00:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02R1vsJ2088300;
        Fri, 27 Mar 2020 02:00:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3003gmyrg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 02:00:34 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02R20VP7011696;
        Fri, 27 Mar 2020 02:00:31 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Mar 2020 19:00:30 -0700
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     lduncan@suse.com, bvanassche@acm.org, open-iscsi@googlegroups.com,
        cleech@redhat.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, kernel@collabora.com,
        Khazhismel Kumykov <khazhy@google.com>,
        Junho Ryu <jayr@google.com>
Subject: Re: [PATCH RESEND v4] iscsi: Report connection state on sysfs
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200317233422.532961-1-krisman@collabora.com>
Date:   Thu, 26 Mar 2020 22:00:27 -0400
In-Reply-To: <20200317233422.532961-1-krisman@collabora.com> (Gabriel Krisman
        Bertazi's message of "Tue, 17 Mar 2020 19:34:22 -0400")
Message-ID: <yq1369uftfo.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003270014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003270014
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Gabriel,

> If an iSCSI connection happens to fail while the daemon isn't running
> (due to a crash or for another reason), the kernel failure report is
> not received.  When the daemon restarts, there is insufficient kernel
> state in sysfs for it to know that this happened.  open-iscsi tries to
> reopen every connection, but on different initiators, we'd like to
> know which connections have failed.

Applied to 5.7/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
