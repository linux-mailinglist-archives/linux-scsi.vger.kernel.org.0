Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43859A29D6
	for <lists+linux-scsi@lfdr.de>; Fri, 30 Aug 2019 00:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfH2Wkm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 29 Aug 2019 18:40:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60820 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfH2Wkm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 29 Aug 2019 18:40:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7TMdm9n025184;
        Thu, 29 Aug 2019 22:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=p5XboHPEsjuMq57E1RRwft/aFkGWzy1Dt70dyabjgHo=;
 b=cHJ+dQNsiPW0/uRZ5QUkSe7j1ZujCHcjINjnNASoEaj4fq5VGBZOSEM0QCvFmUEEzu7G
 F1/JmIo2mr96rqjiDFoQ9U71V2HZLk+vjRjPC0ryHkcIsXZbloNnm4tj0wLunU/h+wFM
 +is0Ioaia53m9ILa84u89F6N8vQQ79vlOo3DXChAeW+wQXZYhodwwI1OWBWDKU2bs9tY
 4Y/d1ndSFvHSSABZJK+vHT5NSqZ4StUQHF/v0dIKigDjzwcrIic5VTcDZSgiThpa6n+d
 ylZ9DcYbGPEGPYG8GbQ/HyYIy+w6vM70r9qXCBiZFekUakZIiLOn/vSkrct+7ZioGwcl xA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2upqnsg07r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 22:40:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7TMc6U7014596;
        Thu, 29 Aug 2019 22:40:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2unvu0q5k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 22:40:09 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7TMe6af005524;
        Thu, 29 Aug 2019 22:40:07 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Aug 2019 15:40:06 -0700
To:     Don Brace <don.brace@microsemi.com>
Cc:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <bader.alisaleh@microchip.com>, <gerry.morong@microchip.com>,
        <mahesh.rajashekhara@microchip.com>, <hch@infradead.org>,
        <jejb@linux.vnet.ibm.com>, <joseph.szczypek@hpe.com>,
        <POSWALD@suse.com>, <shunyong.yang@hxt-semitech.com>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 00/11] smartpqi updates
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <156650628375.18562.9889154437665249418.stgit@brunhilda>
Date:   Thu, 29 Aug 2019 18:40:03 -0400
In-Reply-To: <156650628375.18562.9889154437665249418.stgit@brunhilda> (Don
        Brace's message of "Thu, 22 Aug 2019 15:38:51 -0500")
Message-ID: <yq1v9ufppdo.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9364 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=988
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908290225
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9364 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908290225
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Don,

> These patches are based on Linus's tree

Applied to 5.4/scsi-queue. In the future, please make your commit
descriptions a bit more verbose. Doesn't matter for adding new PCI ids.
But it would be nice with some additional background for the more
intricate functional driver changes.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
