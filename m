Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20881BAF43
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Apr 2020 22:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgD0UVl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 27 Apr 2020 16:21:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54838 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbgD0UVk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 27 Apr 2020 16:21:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03RKJHMH142295;
        Mon, 27 Apr 2020 20:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=nfDZXzDDq2IdOJ9Z4TzjWiheiR5hUufwI5GIJuhehf0=;
 b=rZOMokMFFy9eh0M4iEBW0TejwNQ8GIAy3qiSVtMlNrdxY1D7vXKAUqAD4hYDJvBJ10XB
 E1gvXVTiaw551S3Jlya+cSBxUvd5DEdtyijLZp9FyyBvvJAlnSkbO2z+5/aGim7gJjAy
 0LZauPfvjrs+T7MaCC+s1XxVFnsWDL0U4fTrWcTJ1kikBjN7/Rdoj9nnJ7HiG1KixbUW
 t2iJ3DucbJjKClNv34jWC4rIxykcccbBAbWduRfffzbnE/ZrMejf85kSwWMab3MWNi1N
 Y1ww07PigFjkNQHT/Y1OX+p1PLzss5jG8BQjNnYDaZeFXV8AGBDjT4zFlJq9Bzed7Ymf 0w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30p01njdw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 20:21:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03RKCu7Q104329;
        Mon, 27 Apr 2020 20:21:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30my0agka7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 20:21:32 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03RKLWdK004208;
        Mon, 27 Apr 2020 20:21:32 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Apr 2020 13:21:31 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-kernel@vger.kernel.org, jejb@linux.ibm.com,
        QLogic-Storage-Upstream@qlogic.com, linux-scsi@vger.kernel.org,
        Jason Yan <yanaijie@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: qla4xxx: remove unneeded semicolon in ql4_os.c
Date:   Mon, 27 Apr 2020 16:21:20 -0400
Message-Id: <158777063305.4076.8316002801427063903.b4-ty@oracle.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200421034038.28113-1-yanaijie@huawei.com>
References: <20200421034038.28113-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9604 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=903 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004270164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9604 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 clxscore=1015
 phishscore=0 mlxlogscore=974 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004270164
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 21 Apr 2020 11:40:38 +0800, Jason Yan wrote:

> Fix the following coccicheck warning:
> 
> drivers/scsi/qla4xxx/ql4_os.c:969:3-4: Unneeded semicolon

Applied to 5.8/scsi-queue, thanks!

[1/1] scsi: qla4xxx: Remove unneeded semicolon in ql4_os.c
      https://git.kernel.org/mkp/scsi/c/9b77c9da6a1f

-- 
Martin K. Petersen	Oracle Linux Engineering
