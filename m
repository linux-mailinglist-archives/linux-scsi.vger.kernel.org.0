Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5142B58AF
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Nov 2020 05:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgKQEDw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 16 Nov 2020 23:03:52 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49820 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbgKQEDw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 16 Nov 2020 23:03:52 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AH43Z6g011665;
        Tue, 17 Nov 2020 04:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=Jy/gSyYk9D7jsFXVxpey1uY7mmnXhr3ZFDEM29gbHcI=;
 b=z7OTY8l2lTSH59JJ4qKS4ij0bIIO9Y7LNC5mrQhMHHS3Da6bZ5+SgsCSeW51SN9Nqhxe
 N5TYGfC6Fh8Rm/18h4xKHlrnRcvWuCNWPuUl0bqM9ghgb2ZZ6l90146awyhpcxVRnZgQ
 EgICDVLo0ipdG0lGc+f5DNqWQCHQjcU7ohC41QFUW4oZHZM6Q9P84DrbXmVPdJGIQ3cC
 aqsz7bD16RaZ1kuAUfckVRluWoUPLcNZreysDcLTCRiaM6OB2QlafeL96eIkIzkSVUug
 T+6yXkJJTyXkFtY2rU9zXegwXaasSBrRs+ELhLC0MDmr0ffVH+igs4CDwhhwPJQyxHqA rQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34t7vn0cxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 04:03:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AH41GUj053502;
        Tue, 17 Nov 2020 04:03:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34umcxmwsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 04:03:37 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AH43UTW005469;
        Tue, 17 Nov 2020 04:03:31 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 20:03:30 -0800
To:     Don Brace <don.brace@microchip.com>
Cc:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <gerry.morong@microchip.com>, <mahesh.rajashekhara@microchip.com>,
        <hch@infradead.org>, <jejb@linux.vnet.ibm.com>,
        <joseph.szczypek@hpe.com>, <POSWALD@suse.com>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/3] smartpqi updates
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y2j04ol7.fsf@ca-mkp.ca.oracle.com>
References: <160512621964.2359.14416010917893813538.stgit@brunhilda>
Date:   Mon, 16 Nov 2020 23:03:27 -0500
In-Reply-To: <160512621964.2359.14416010917893813538.stgit@brunhilda> (Don
        Brace's message of "Wed, 11 Nov 2020 14:24:33 -0600")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=866 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170028
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=880 suspectscore=1
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170029
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Don,

> This small set of changes consist of two minor bug fixes:
>   * Remove an unbalanced call to pqi_ctrl_unbusy in the smp
>     handler. There is not a call to pqi_ctrl_busy.
>   * Correct driver rmmod hang when using HBA disks with
>     write cache enabled. During removal, SCSI SYNCHRONIZE CACHE
>     requests are blocked with SCSI_MLQUEUE_HOST_BUSY which cause
>     the hang.

Applied to 5.11/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
