import React from 'react'
import { useQuery, useMutation } from 'urql';

const ReminderListQuery = `
  query ReminderList {
    reminderList {
      id
      title
      reminderGroup {
        id
        name
      }
      reminderGroupId
      updatedAt
    }
  }
`;

const ReminderDeleteMutation = `
  mutation($id: Int!) {
    deleteReminder(id: $id) {
      success
    }
  }
`

const ReminderList = () => {
  const [result, reexecuteQuery] = useQuery({
    query: ReminderListQuery,
    requestPolicy: 'network-only'
  });

  const [state, executeMutation] = useMutation(ReminderDeleteMutation)

  const deleteReminder = React.useCallback((id) => {
    executeMutation({ id })
    reexecuteQuery()
  })

  const { data, fetching, error } = result;

  if (fetching) return <p>Loading...</p>;
  if (error) return <p>Oh no... {error.message}</p>;

  return (
    <div>
    <table className="table-auto">
    <thead>
      <tr>
        <th className="px-4 py-2">ID</th>
        <th className="px-4 py-2">Title</th>
        <th className="px-4 py-2">Updated at</th>
        <th className="px-4 py-2">Group</th>
        <th className="px-4 py-2">Actions</th>
      </tr>
    </thead>
    <tbody>
    {data.reminderList.map(reminder => (
      <tr key={reminder.id}>
        <td className="border px-4 py-2">{reminder.id}</td>
        <td className="border px-4 py-2">{reminder.title}</td>
        <td className="border px-4 py-2">{reminder.updatedAt}</td>
        <td className="border px-4 py-2">{reminder.reminderGroup?.name }</td>
        <td className="border px-4 py-2">
          <button className="bg-red-500 hover:bg-red-700 text-white py-1 px-3 rounded text-xs " onClick={() => deleteReminder(reminder.id)}>Delete</button>
        </td>
      </tr>
    ))}
    </tbody>
    </table>
    </div>
  );
};


export default ReminderList;