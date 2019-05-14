Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 137B41CE13
	for <lists+linux-scsi@lfdr.de>; Tue, 14 May 2019 19:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfENRfU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 May 2019 13:35:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59030 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfENRfU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 May 2019 13:35:20 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4EHOH48162648;
        Tue, 14 May 2019 17:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=6Hoi0M60r8EPUoEKBA7eiaC90upth8bPod4z5Q14Bk4=;
 b=4GnfD/BzjD+97Zd7bqCegpfrj0Nw5y7Avqn0bOuvSz7t5iXHVj5nwYFWMHC3afxWd/2g
 16mKLZSgJrjQbL/6s93hfL3gR9WsWh/r26afYxzEKUP44NHhCcNz7E8jqWa4Dvwp+tNH
 YqGyAJ9MI/cDVTjx6jhVB3hA1mB2MsuVTlUEVXEsk8QmaK5UhUinT7oHlpdXkB90kmB6
 mlMAVCIPGYxw410xUz0x7iYHA3KiFp9wPJ/4ip7AFK38F0VSf1mYDk7DdOK98SvgnGMc
 YgZvCvKxs7nlo68TDuozFxWHx09gSDDC8vVQspW+jKLJaUJnLbkizyF4DZsjLF7Wjxuh jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2sdkwdqy95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 17:34:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4EHYBB1016923;
        Tue, 14 May 2019 17:34:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2sf3cnd41j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 17:34:31 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4EHYT6a020940;
        Tue, 14 May 2019 17:34:29 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 May 2019 10:34:28 -0700
To:     Don Brace <don.brace@microsemi.com>
Cc:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <bader.alisaleh@microchip.com>, <gerry.morong@microchip.com>,
        <mahesh.rajashekhara@microchip.com>, <hch@infradead.org>,
        <jejb@linux.vnet.ibm.com>, <joseph.szczypek@hpe.com>,
        <POSWALD@suse.com>, <shunyong.yang@hxt-semitech.com>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/7] hpsa updates
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <155725372104.27200.12250663760304977059.stgit@brunhilda>
Date:   Tue, 14 May 2019 13:34:25 -0400
In-Reply-To: <155725372104.27200.12250663760304977059.stgit@brunhilda> (Don
        Brace's message of "Tue, 7 May 2019 13:31:54 -0500")
Message-ID: <yq1v9ydc53y.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=912
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905140120
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=934 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905140120
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Don,

> Don Brace (7):
>       hpsa: correct simple mode
>       hpsa: use local workqueues instead of system workqueues
>       hpsa: check for tag collision
>       hpsa: wait longer for ptraid commands
>       hpsa: do-not-complete-cmds-for-deleted-devices
>       hpsa: correct device resets
>       hpsa: update driver version

Applied to 5.3/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
