#! /bin/sh
#    Copyright (C) 2017 Jorge Cataño
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.


#############################################################################
###                         First screen                                  ###
#############################################################################
clear
echo "Copyright (C) 2017 Jorge Cataño"
echo "This program comes with ABSOLUTELY NO WARRANTY."
echo "This is free software, and you are welcome to "
echo "redistribute it under certain conditions."
echo "See <http://www.gnu.org/licenses/> for details."
echo ""
echo " We will help you to update your ssh key on the remote server."
echo ""
echo " Type the next info:"
echo ""

#############################################################################
###                         REMOTE SERVER                                 ###
#############################################################################

i=0
while [  $i -lt "3" ]
do
echo -n  "Remote server (name or IP): "; read SERVIDOR
if [ -z $SERVIDOR ]
then
i = `expr $i + 1`
else
break
fi

if [ $i  =  "3" ]
then
echo "error 1: Remote server must by known."
exit 1
fi
done

#############################################################################
###                              NEW KEY                                  ###
#############################################################################
nuevaclave(){	
i=0
while [  $i -lt "3" ]
do
echo -n  "New key: "; read nueva
if [ -z $nueva ]
then
i=`expr $i + 1`
else
break
fi
if [ $i  =  "3" ]
then
echo "error 5: new key can not be emty."
exit 5
fi
done
}

nuevaconfirmanuevaclave(){
i=0
while [  $i -lt "3" ]
do
echo -n  "Type again new key: "; read nuevaconfirma
if [ -z $nuevaconfirma ]
then
i=`expr $i + 1`
else
break
fi
if [ $i  =  "3" ]
then
echo "error 6: new key confirmation could not be emty."
exit 6
fi
done
}

echo "Bring the next information required:"
nuevaclave
nuevaconfirmanuevaclave

a=0
while [  $a -lt "3" ]
do
if [ $nueva != $nuevaconfirma ]
then
echo "New public key has not been confirmed. Try again."
a=`expr $a + 1`
nuevaclave
nuevaconfirmanuevaclave
else
break
fi

if [ $a  =  "3" ]
then
echo "error 7: Sorry!. New public key was not confirmed."
exit 7
fi
done

ssh-keygen -b 4096 -t rsa -f clave -P $nueva 
ssh-copy-id  -i clave.pub  $USER@$SERVIDOR 
cp clave.pub /home/$USER/.ssh/id_rsa.pub 
cp clave /home/$USER/.ssh/id_rsa
rm clave.pub
rm clave
